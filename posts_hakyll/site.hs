--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>))
import           Hakyll

import           System.FilePath.Posix (takeBaseName, (</>), takeDirectory, splitFileName)
import  Data.List(isInfixOf)

import qualified Data.Set as S
import qualified Data.Map as M
import           Text.Pandoc.Options

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "templates/*" $ compile templateCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "posts_markdown/*" $ do
        route   postRoute
        compile $ pandocCompilerWith defaultHakyllReaderOptions pandocOptions
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" (mathCtx <> defaultContext)
            >>= relativizeUrls
            >>= removeIndexHtml

    match "index.html" $ do
        route   idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts_markdown/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) <>
                    constField "title" "Index"                <>
                    mathCtx <>
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls
                >>= removeIndexHtml



--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    defaultContext

postRoute :: Routes
postRoute =
    gsubRoute "posts_markdown/" (const "") `composeRoutes`
    gsubRoute "/[0-9]{4}-[0-9]{2}-[0-9]{2}-" (const "/") `composeRoutes`
    customRoute (\st -> let p=toFilePath st in takeBaseName p </> "index.html")

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

mathCtx :: Context String
mathCtx = field "mathjax" $ \item -> do
    metadata <- getMetadata $ itemIdentifier item
    let mathjaxTag = "<script src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\" type=\"text/javascript\"></script>"
    return $ if M.member "mathjax" metadata then mathjaxTag else ""
