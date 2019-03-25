"""
    initlibs(topdir, template)

Internal function to copy over the `katex` and `highlight` libraries to the `libs/` folder
of the website folder. See [`newsite`](@ref).
"""
function initlibs(topdir::String, template::String)
    libs = mkdir(joinpath(topdir, "libs"))
    # katex
    cp(joinpath(JUDOC_PATH, "templates", "common", "katex"), joinpath(libs, "katex"))
    # highlight
    # NOTE: it's better if the user copies/pastes their own stuff, this is a default one
    # so that they get a template, languages = {julia, julia REPL, python, R, markdown, bash}
    cp(joinpath(JUDOC_PATH, "templates", "common", "highlight"), joinpath(libs, "highlight"))
    return nothing
end

"""
    initsrc(topdir, template)

Internal function to copy over the `src/` folder from a given template to the website folder.
See [`newsite`](@ref).
"""
function initsrc(topdir::String, template::String)
    src = mkdir(joinpath(topdir, "src"))
    cp(joinpath(JUDOC_PATH, "templates", template, "_css"), joinpath(src, "_css"))
    cp(joinpath(JUDOC_PATH, "templates", template, "_html_parts"), joinpath(src, "_html_parts"))
    cp(joinpath(JUDOC_PATH, "templates", template, "pages"), joinpath(src, "pages"))
    cp(joinpath(JUDOC_PATH, "templates", template, "config.md"), joinpath(src, "config.md"))
    cp(joinpath(JUDOC_PATH, "templates", template, "index.md"), joinpath(src, "index.md"))
end

"""
    initassets(topdir, template)

Internal function to copy over the `assets/` folder from a given template to the website folder.
See [`newsite`](@ref).
"""
function initassets(topdir::String, template::String)
    cp(joinpath(JUDOC_PATH, "templates", template, "assets"), joinpath(topdir, "assets"))
end

"""
    newsite(topdir, template)

Generate a new folder (an error is thrown if it already exists) that contains the skeleton of a
website that can be processed by JuDoc. The user can specify a `template`.
Note that the function changes the current directory to that of the `topdir` so that the user can
directly use `serve()` to live serve the website and start modifying it.

### Example
```julia
newsite("MyNewWebsite")
serve()
```
"""
function newsite(topdir::String="TestWebsite";
                 template::String="basic")

    topdir = mkdir(topdir)
    initlibs(topdir, template)
    initsrc(topdir, template)
    initassets(topdir, template)
    cd(topdir)
    println("✓ Website folder generated at $(topdir) (now the current directory).")
    println("→ Use `serve()` to render the website and see it in your browser.")
    return nothing
end