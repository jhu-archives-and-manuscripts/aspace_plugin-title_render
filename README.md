## Summary

This plugin remedies the worst of the ArchivesSpace v1.5.4 Public User Interface (PUI) <title> tag rendering bugs. It currently does not address
similar issues in staff mode (frontend) and is not applicable to the 2.x versions of ArchivesSpace.

---

## Details

### Breadcrumb tag truncation

ApplicationHelper::truncate() is indescriminate. Failing to account for HTML tags and other elements. This behavior could leave an unclosed element,
leading to strange renderings. If the element is one that does not render in the <body> (e.g., the common <title render="..."> element), the remainder
of the page would be blank.
- Overrides truncate and use the truncate_html gem to perform safe truncation.

### Proper rendering of <title render="italics"> and <title render="doublequote">

MixedContentParser::parse() has code indicating that <title> tags are meant to be handled, but the document is stripped of <title> tags in the "clean" step.
- Override MixedContentParser::parse() to
  - Fix "clean" step to leave "title" tag and its "render" attribute;
  - Add logic to handle render="doublequote"

This works wherever MixedContentParser::parse() is used.

### Render text nodes withing <title> elements in component tree

The text nodes render (i.e., they are visible), but do not respect the value of the "render" attribute (i.e., they are not styled).

NB: It would be more involved to make this work within the JavaScript templating environment used for the component tree.

---

## Activate the plugin
- Install the plugin:
  - Clone this repository into the plugins/title_render directory; or
  - Unzip the release zip into the plugins/title_render directory.

- Initialize the plugin (to install the required Ruby gem):

  $ scripts/initialize-plugin.sh title_render

- Enable the plugin and the associated theme:
  - In config/config.rb, add the plugin name to the "AppConfig[:plugins]" list, e.g.:

    AppConfig[:plugins] = ['title_render']

- Restart ArchivesSpace
