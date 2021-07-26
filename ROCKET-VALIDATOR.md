# Rocket Validator

We're using [Rocket Validator](https://rocketvalidator.com) to check [Beta Elixir School](https://beta.elixirschool.com) for HTML and accessibility issues.

This document is a quick guide on how to use that service, for full documentation please refer to [https://docs.rocketvalidator.com](https://docs.rocketvalidator.com)

## Rocket Validator (RV) in a nutshell

RV is an automated web crawler that finds the internal web pages on a site from a starting URL, and checks each web page found using:

* [W3C HTML Validator](https://validator.w3.org/nu/) to check for HTML issues.
* [Axe-core](https://github.com/dequelabs/axe-core) to check for accessibility issues.

Both checkers are free and open source, and can be used on individual URLs.

Rocket Validator is a web crawler and reporting tool that lets you automatically check thousands of URLs (or just a few) with a single click.

The current site for Beta Elixir School has 1,040 web pages. Imagine if you had to check each web page manually, both for HTML and accessibility issues. That's 2,080 checks needed!

RV lets us automate this site-wide checking and also schedule periodic checks to constanly monitor for new issues.

## Create your RV account

RV is a paid service but Elixir School contributors have a free Pro account to work on this site. If you're an Elixir School contributor you just need to [sign up](https://rocketvalidator.com/registration/new) for a free account, and contact [jaime@rocketvalidator.com](mailto:jaime@rocketvalidator.com) to have your account upgraded to Pro.

## Create your first report

Once you're logged in at RV, you can [create a new report](https://rocketvalidator.com/s/new). You just need to enter a starting URL (https://beta.elixirschool.com), and click on **Start validation**.

Your site validation report will be created, and the crawler will find the internal web pages, and validate each one for HTML and accessibility issues.

On the generated report, you can browse the results per each page found, or go to the **Common HTML issues** or **Common accessibility issues** tabs to find the issues found on the site, grouped by the kind of issue. The reports give you details of the affected pages, and the affected elements within each page.

## How to validate your local server

RV can validate any site that has public URLs, and that includes your local development server if you use something like [ngrok](https://ngrok.com) to create a temporary public URL for your dev server.

Here's a [guide](https://docs.rocketvalidator.com/how-to-validate-your-local-server/) with more info but in short here's what you do:

1. Launch the phoenix app, like in `iex -S mix phx.server`.
2. Launch ngrok telling it to expose port 4000 and give it a meaningful URL, like `ngrok http 4000 --subdomain elixirschool-joe`.
3. This will create a temporary public URL https://elixirschool-joe.ngrok.io that you can use to validate your dev site on RV.

Just remember to change `joe` by your name or whatever other string you want, but keep `elixirschool` somewhere on the URL to make it easier working with muting rules.

## Muting issues

There are some issues that we can decide not to fix, for example HTML markup that is not correct by current standards, but is required by a third party tool, so it's out of our scope. Muting rules in RV lets us hide these issues on the reports. You can read the [muting guide](https://docs.rocketvalidator.com/muting/) to see how it works, but basically a muting rule needs:

* A string to match URLs. It can be a whole URL if you want to be specific, or just a substring like `elixirschool`, which is recommended as it will match both on the beta, staging and production sites, as well as your ngrok instances if you include that on the name.
* A string to match the issue message. A substring is enough, for example matching on `Attribute “phx-` will hide all issues regarding about invalid attributes set by Phoenix.

https://rocketvalidator.com/domains/beta.elixirschool.com?tab=mutings&date=&auth=e536facf-2cba-4288-ba45-3e7b95addcf8

### Muting rules for Elixir School

Each RV user defines his own muting rules, here is [what we've agreed to mute](https://rocketvalidator.com/domains/beta.elixirschool.com?tab=mutings&date=&auth=e536facf-2cba-4288-ba45-3e7b95addcf8):

| URL match    | Message match     | Reason                                                       |
| ------------ | ----------------- | ------------------------------------------------------------ |
| elixirschool | Attribute “@click | Required by Alpine.js.                                       |
| elixirschool | Attribute “phx-   | Required by Phoenix framework.                               |
| elixirschool | Attribute “x-     | Required by Alpine.js.                                       |
| elixirschool | Bad value “{%     | Wrong content in some posts, will be reviewed before launch. |
| elixirschool | This document appears to be written in English but the “html” start tag has “lang= | Pending translation. We already have a mechanism to track content waiting to be translated. |

## Shared Domain Stats

RV generates daily domain stats based on the reports you run, which can be shared by RV users. We're using the ones shared from @jaimeiniesta's account as a central reference:

[Latest Stats and Reports for Beta Elixir School](https://rocketvalidator.com/domains/beta.elixirschool.com?tab=mutings&date=&auth=e536facf-2cba-4288-ba45-3e7b95addcf8)

## Scheduling Reports

Reports can be run automatically a schedule. For example in @jaimeniesta's account there's a weekly schedule to run a full report every Monday.

[Read about Scheduling](https://docs.rocketvalidator.com/scheduling/)

## Deploy Hooks

Reports can also be triggered automatically after a server deploy. This can be useful in staging deploys for example.

[Read about Deploy Hooks](https://docs.rocketvalidator.com/deploy-hooks/)

