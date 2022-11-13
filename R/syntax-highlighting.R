# Manual

# light theme

theme_light <- readLines("assets/template-light.theme")
# theme renamed from arrow-light.theme, found in quarto-cli, then saved into my root directory
# also added in text-styles present in arrow-dark but not in arrow-light


# apply my colours
theme_light <- gsub("#AD0000", "#B6005B", theme_light) # red -> pink
theme_light <- gsub("#8f5902", "#B55A00", theme_light) # brown -> orange (note lower case!)
theme_light <- gsub("#00769E", "#5B00B6", theme_light) # blue -> purple
theme_light <- gsub("#657422", "#5B00B6", theme_light) # light-green -> purple (attributes)
theme_light <- gsub("#20794D", "#008542", theme_light) # green -> green
theme_light <- gsub("#4758AB", "#005BB6", theme_light) # purple -> blue
theme_light <- gsub("#5E5E5E", "#494957", theme_light) # mid-gray -> gray-700
theme_light <- gsub("#f1f3f5", "#E9E9EF", theme_light) # light-gray -> gray-200 # background colour - doesn't make a difference
theme_light <- gsub("#111111", "#212129", theme_light) # dark-gray -> gray-900
theme_light <- gsub("#003B4F", "#212129", theme_light) # dark-blue -> gray-900
theme_light <- gsub("#aaaaaa", "#ADADBD", theme_light) # mid-gray -> dark-500 
# Other set manually to #494957 (gray-700) in template-light
# ControlFlow set manually to #B55A00 (orange) in template-light


writeLines(theme_light, "ek-light.theme")

# Manual

# dark theme

theme_dark <- readLines("template-light.theme")


# apply my colours (2)
theme_dark  <- gsub("#AD0000", "#FF2B95", theme_dark ) # red -> pink
theme_dark  <- gsub("#8f5902", "#FF962C", theme_dark ) # brown -> brown (note lower case!)
theme_dark  <- gsub("#00769E", "#B062FF", theme_dark ) # blue -> purple
theme_dark  <- gsub("#657422", "#B062FF", theme_dark ) # light-green -> purple (attributes)
theme_dark  <- gsub("#20794D", "#00E673", theme_dark ) # green -> green
theme_dark  <- gsub("#4758AB", "#2C95FF", theme_dark ) # purple -> blue
theme_dark  <- gsub("#5E5E5E", "#DCDCE6", theme_dark ) # mid-gray -> gray-300
theme_dark  <- gsub("#f1f3f5", "#343440", theme_dark ) # light-gray -> gray-800 # background colour - doesn't make a difference
theme_dark  <- gsub("#111111", "#F8F8FA", theme_dark ) # dark-gray -> gray-100
theme_dark  <- gsub("#003B4F", "#F8F8FA", theme_dark ) # dark-blue -> gray-100
theme_dark  <- gsub("#aaaaaa", "#ADADBD", theme_dark ) # mid-gray -> dark-500 
theme_dark  <- gsub("#494957", "#DCDCE6", theme_dark ) # gray-300 Other (assignment)
theme_dark  <- gsub("#B55A00", "#FF962C", theme_dark ) # orange ControlFlow

writeLines(theme_dark, "ek-dark.theme")

