---
title: Getting started with Hakyll
author: Ross
published: 2015-01-04
---

So a new year and a new resolution; to write something everyday. So far I've failed thrice, which is about par for the course. I blame setting things up in Hakyll. It was far more painful than I expected, which explains why so many Hakyll blogs are super close to default/ each other.

The first issue I had was getting Hakyll installed in the correct folder. Because I've moved to putting all Haskell packages into sandboxes everything had to be built from scratch. The first issue was then I couldn't compile Pandoc. I froze up the whole machine. I killed it and tried again with the same issue. Turns out it was running out of memory. A bit of googling confirmed my suspicion and further googling suggested turning off optimisation (--ghc-options="-O0" to cabal), as I have it turned on by default.

The next issue was that I wasn't sure which folder to build it in. And it turns out that sandboxes use and build in hardwired global paths, so you can't move/rename the folder. I looked for scripts that would move a cabal sandbox, but no avail. In sum, I ended up building Hakyll 4 times (in ./essays, ./, ./essays and finally ./essays_hakyll). I should really investigate a common shared sandbox approach based on using a stackage plan file (Is there a better name for them? The cabal.config file with the versions pegged.).

Okay, so Hakyll is installed and the example site will build. At this point things are back to fun for a bit as I browse other people's configs and read the tutorials to see how things go together. I decided that the example site was petty close to what I wanted anyway, so I just took a knife to the home page and archive page and copied across some of my styles from the old version. No result, site continues to look exactly the same. Make some other changes, nada. Is the site actually rebuilding? Yes (use the rebuild command to site rather than clean && build). Oh the site.hs file has to be rebuilt into the binary. Ahaha, cabal isn't detecting any changes. Yup, editing the wrong site.hs file somehow.

Next, content is up, page looks how I want (for now at least). Followed some friendly advice to change the path names to something pretty. Bit of a struggle to change the route to get rid of "^posts/" (really should learn decent text wrangling in Haskell someday), but I get there. I look at the posts to fid that the mathjax is only half working. Sad face. Seems the problem is that pandoc is mathjax away and transforming it for me. How helpful /s. Find a several tutes all copying the same guy about how to stop it processing (by default it does it best to change all the symbols into unicode. wtf, it looks awful and wrecks alignment. bah.). Look at site, no mathjax at all.

Quick fiddles didn't work, so I made a fresh test page with all the possible math delimiters. I see that pandoc is helpfully changing $ \alpha $ to \( \alpha \) which is the preferred mathjax style, but for the life of me I can't figure out why mathjax isn't rendering. The script tag is in the header. Try moving it to the body, to after the text. Verify that it is loading. At this point I really crack out the documentation and read large chunks of pandoc markdown/mathjax/html config options, ditto with mathjax. Try all possible combinations of parameters.

This problem gets three paragraphs because it took me almost 3 hours to figure it out. In desperation I start trying to get it to work at all in my browser. The example page on the mathjax website renders. I start striping out element from the page. Good by div, span, head. Wait. It's working. Slowly put things back into place one at a time. It turns out the <?xml> tag at the very top of the file was for some reason blocking mathjax from working. Not sure if it had something to do with it specifying UTF-8 and that messing with the matching of the characters (no idea if that's even a possible thing). Don't care, my equations are back.

Everything is good enough to go. Push to github. Nothing there, it's still the old version. Okay 'can take up to 30 mins to refresh' according to github, so let's just be patient. Watch an episode of Brooklyn Nine-Nine which is reasonably entertaining; good recommendation Pat. Come back still not working. I should mention that I'm using a link to point ./essays at ./essays_hakyll/\_ site/ . Mr Google, do links work on github pages? Yes, but only if you disable Jekyll (which I guess is Hakyll's evil alter ego :P) and from the github pages themselves, Jekyll treats folders beginning with an underscore as special. Which, as I write this, should have been obvious since Hakyll does too. .nojekyll in root, and voila, link is working.

But that wasn't even my final form! Clicking on a post tries to download it as a binary file. So I guess github is guessing mime type by file extension. Fortunately somebodies dumb solution to getting fancy post urls was exactly the solution I needed. Route each post to its own folder as the index.html file and add a thingy to scrub all the links of the final index.html. Copy+paste thank you very much.

And such an ordeal, I'm glad things are up and running, and only a slight improvement over the zsh I had that processed the markdown and sliced it between a header and footer template. Yipee.