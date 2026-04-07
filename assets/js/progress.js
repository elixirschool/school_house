const STORAGE_KEY = 'elixirschool_progress'
const CURRENT_VERSION = 1
const MIN_TIME_BEFORE_COMPLETE = 2000 // ms - guard against instant completion on short lessons
const TOAST_DURATION = 2500 // ms - how long the completion toast is shown

function loadProgress() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (!raw) return defaultProgress()
    const data = JSON.parse(raw)
    if (data.version !== CURRENT_VERSION) return defaultProgress()
    return data
  } catch {
    return defaultProgress()
  }
}

function defaultProgress() {
  return { version: CURRENT_VERSION, completed: [], lastVisited: null }
}

function saveProgress(data) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(data))
  } catch {
    // localStorage full or disabled — silently degrade
  }
}

document.addEventListener('alpine:init', () => {
  const progress = loadProgress()
  const pageLoadTime = Date.now()

  Alpine.store('progress', {
    completed: progress.completed,
    lastVisited: progress.lastVisited,
    showToast: false,

    isCompleted(lessonId) {
      return this.completed.includes(lessonId)
    },

    markComplete(lessonId) {
      if (this.completed.includes(lessonId)) return
      this.completed.push(lessonId)
      this._persist()
      this._flashToast()
    },

    markVisited(section, name) {
      this.lastVisited = { section, name, timestamp: Date.now() }
      this._persist()
    },

    completedInSection(section) {
      let count = 0
      for (const id of this.completed) {
        if (id.startsWith(section + '/')) count++
      }
      return count
    },

    observeLesson(section, name) {
      const lessonId = section + '/' + name
      const sentinel = document.getElementById('lesson-end')
      if (!sentinel) return

      const observer = new IntersectionObserver((entries) => {
        for (const entry of entries) {
          if (!entry.isIntersecting) continue
          if (this.isCompleted(lessonId)) {
            observer.disconnect()
            return
          }

          const elapsed = Date.now() - pageLoadTime
          if (elapsed >= MIN_TIME_BEFORE_COMPLETE) {
            this.markComplete(lessonId)
            observer.disconnect()
          } else {
            // Short lesson — wait until minimum time has passed
            setTimeout(() => {
              this.markComplete(lessonId)
              observer.disconnect()
            }, MIN_TIME_BEFORE_COMPLETE - elapsed)
          }
        }
      }, { threshold: 0.1 })

      observer.observe(sentinel)
    },

    _persist() {
      saveProgress({
        version: CURRENT_VERSION,
        completed: this.completed,
        lastVisited: this.lastVisited
      })
    },

    _flashToast() {
      this.showToast = true
      setTimeout(() => { this.showToast = false }, TOAST_DURATION)
    }
  })
})
