--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>))
import           Hakyll

import           System.FilePath.Posix (takeBaseName, (</>), takeDirectory, splitFileName)
import  Data.List(isInfixOf)

import qualified Data.Set as S
import qualified Data.HashMap.Lazy as HM
import           Text.Pandoc.Options

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "templates/*" $ compile templateCompiler

-- posts
    create ["posts/index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts_markdown/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) <>
                    constField "title" "Posts" <>
                    postCtx

            makeItem ""
                >>= loadAndApplyTemplate "templates/post-list.html" indexCtx
                >>= loadAndApplyTemplate "templates/posts-default.html" indexCtx
                >>= relativizeUrls
                >>= removeIndexHtml

    match "css/*" $ version "posts" $ do
        route   (gsubRoute "css/" (const "posts/css/"))
        compile compressCssCompiler
    
    match "posts_markdown/images/*" $ do
        route   (gsubRoute "posts_markdown/" (const "posts/"))
        compile copyFileCompiler

    match "posts_markdown/*.md" $ do
        route   postRoute
        compile $ pandocCompilerWith defaultHakyllReaderOptions pandocOptions
            >>= loadAndApplyTemplate "templates/post-info.html" postCtx
            >>= loadAndApplyTemplate "templates/posts-default.html" postCtx
            >>= relativizeUrls
            >>= removeIndexHtml

-- triple j stuff
    create ["triplej/index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts_markdown_triplej/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) <>
                    constField "title" "Triple J Hottest 100 Facts" <>
                    postCtx

            makeItem ""
                >>= loadAndApplyTemplate "templates/post-list.html" indexCtx
                >>= loadAndApplyTemplate "templates/triplej-default.html" indexCtx
                >>= relativizeUrls
                >>= removeIndexHtml

    match "css/*" $ version "triplej" $ do
        route   (gsubRoute "css/" (const "triplej/css/"))
        compile compressCssCompiler
    
    match "posts_markdown_triplej/images/*" $ do
        route   (gsubRoute "posts_markdown_triplej/" (const "triplej/"))
        compile copyFileCompiler
    
    match "posts_markdown_triplej/*.md" $ do
        route   postRouteTriplej
        compile $ pandocCompilerWith defaultHakyllReaderOptions pandocOptions
            >>= loadAndApplyTemplate "templates/post-info.html"    postCtx
            >>= loadAndApplyTemplate "templates/triplej-default.html" postCtx
            >>= relativizeUrls
            >>= removeIndexHtml


--------------------------------------------------------------------------------
postRoute :: Routes
postRoute =
    gsubRoute "posts_markdown/" (const "") `composeRoutes`
    gsubRoute "/[0-9]{4}-[0-9]{2}-[0-9]{2}-" (const "") `composeRoutes`
    customRoute (\st -> let p=toFilePath st in "posts" </> takeBaseName p </> "index.html")

postRouteTriplej :: Routes
postRouteTriplej =
    gsubRoute "posts_markdown_triplej/" (const "") `composeRoutes`
    gsubRoute "/[0-9]{4}-[0-9]{2}-[0-9]{2}-" (const "") `composeRoutes`
    customRoute (\st -> let p=toFilePath st in "triplej" </> takeBaseName p </> "index.html")



-- replace url of the form foo/bar/index.html by foo/bar
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item
    where
        removeIndexStr :: String -> String
        removeIndexStr url = case splitFileName url of
            (dir, "index.html") | not ("://" `isInfixOf` dir) -> dir
            _ -> url

pandocOptions :: WriterOptions
pandocOptions = defaultHakyllWriterOptions {writerExtensions = newExtensions, writerHTMLMathMethod = MathJax "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"}
    where
        mathExtensions = [Ext_tex_math_dollars, Ext_tex_math_double_backslash]
        defaultExtensions = writerExtensions defaultHakyllWriterOptions
        newExtensions = foldr S.insert defaultExtensions mathExtensions


postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    mathCtx <>
    defaultContext

mathCtx :: Context String
mathCtx = field "mathjax" $ \item -> do
    metadata <- getMetadata $ itemIdentifier item
    let mathjaxTag = "<script src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\" type=\"text/javascript\"></script>"
    return $ if HM.member "mathjax" metadata then mathjaxTag else ""

