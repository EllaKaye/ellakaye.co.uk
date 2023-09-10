My personal website, portfolio and blog, <https://ellakaye.co.uk>.

Built with [Quarto](https://quarto.org), deployed manually with [Netlify](https://www.netlify.com).

Because the website is deployed manually, this repo may not always be completely in sync with the published site, though I will endeavour to keep them close. The website deploys from my local machine because I use fonts that I have bought licenses for and I cannot make these font files  publicly available on GitHub. I wish for the rest of the code to be public.

## Notes on adapting this code

I'm thrilled that my site has received a fair amount of attention and it seems that many people like it! People are free to use this code as inspiration for or a starting point for their own sites, though please note the following:

### License

The code for the website is licensed under a is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/) (CC BY-SA 4.0).

### Files to modify

If you take this repo as the starting point for your own site, you will need to adapt at least a couple of files.

1. `_quarto.yml`

This file contains most of the metadata for the site and most of it will need updating with your information, in ways that should be fairly obvious as you read through it (perhaps in conjunction with the [Quarto websites documentation](https://quarto.org/docs/websites/)). In particular, please make sure that you either delete the lines relating to google analytics or update with your own tracking id. (I use analytics with anonymised IPs because I'm interested in how many people visit the site, not for anything else).

2. `_includes/giscus.html`

I use giscus for comments. In order to ensure that the theme of the comments box toggles between light and dark when someone toggles the overall site theme, the way it's set up is somewhat convoluted. In order to make it work for your site, you'll need to work through all the steps on the [giscus](https://giscus.app) page, and then update lines 25-38 (especially lines 26-29) of `_includes/giscus.html` with the values you're given in the 'Enable giscus' section of that page. If you don't do this, any comments on your site will still come through to my repo. If you don't want to include giscus on your site, you'll need to delete the files `_includes/giscus.html` and `_includes/div-giscus.html`, and also remove the lines `include-in-header: ../_includes/giscus.html` and `include-after-body: ../_includes/div-giscus.html` from where they appear in `posts/_metadata.yml`, `talks/_metadata.yml` and `packages/_metadata.yml`. If you do want to include giscus comments but only have one theme (i.e. aren't toggleing between light and dark modes), then I'd still recommend deleting the files and lines above, then using the much simpler [Quarto/giscus](https://quarto.org/docs/output-formats/html-basics.html#commenting) integration.

3. `_publish.yml`

I deploy the site manually to Netlify and this file contains the relevant id and url. I suggest that you delete this file from your copy of the repo and follow the [instructions](https://quarto.org/docs/publishing/) for whatever method of publication you wish to use, which will generate a fresh `_publish.yml` file for you with your site's information, if one is required.

4. `assets/ek-theme-light.scss` and `assets/ek-theme-dark.scss`

I have extensively customised the appearance of my site in the `ek-theme-light.scss` and `ek-theme-darks.scss` files and I would strongly encourage you to modify these to give your site its own distinct visual identity.

#### Fonts

In particular, you will not be able to use the same fonts as I have unless you purchase licenses for them and obtain your own copies of the font files. These are [Lemon Milk Pro](https://www.myfonts.com/collections/lemon-milk-pro-font-marsnev) for body and headings and [MonoLisa](https://www.monolisa.dev) for code. If you do not use these fonts, you should delete or comment out lines 7-51 of the two scss files.

If you prefer to choose your own fonts, there are many excellent free options available. It's particularly easy to integrate [Google fonts](https://fonts.google.com). To help out with this, I've added code to import [Figtree](https://fonts.google.com/specimen/Figtree) for body and headers and [Fira Mono](https://fonts.google.com/specimen/Fira+Mono) for code. You'll have to uncomment lines 53-54. You can easily swap in other fonts from Google fonts into these lines, then update lines 57-59 with your choices.

#### Colours

I put a lot of thought into the [colours](https://ellakaye.co.uk/posts/2021-05-26_custom-highlighting-distill-2/) used throughout my site. Should you wish to use different ones (and, as I said above, I suggest that you do), then accent colours can be edited in lines 104-113 and grays in lines 77-87 of the two scss files. 

If you'd like a custom syntax highlighting theme, the files to modify are `assets/ek-light.theme` and `assets/ek-dark.theme`. These are a faff to modify by hand. You can use the script in `R/syntax-highlighting.R` to ease the process. Or keep things simple by using one of the [built-in options](https://quarto.org/docs/output-formats/html-code.html#highlighting).

### Please let me know!

I love to hear when other people have found my code useful. If that's you, please do [get in touch](https://ellakaye.co.uk/contact) to let me know and share your site with me. It's also a great way for me to get to know other people and their work, and I've come across great projects and ideas this way.
