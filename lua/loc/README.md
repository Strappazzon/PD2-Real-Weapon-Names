# Adding Translations

To illustrate the process of translating, this guide will make an english-pirate translation of Real Weapon Names.

## Getting started

Before you start working on your translation, clone this repository via Git or GitHub Desktop.

```
git clone https://github.com/Strappazzon/PD2-Real-Weapon-Names.git PD2-Real-Weapon-Names
cd PD2-Real-Weapon-Names
```

Now copy the default (English) language file (`/lua/loc/en.json`) to a file named according to your language's [ISO 639-1 Code](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes), like `/lua/loc/pirate.json`.
There is no ISO 639-1 language code for *English-pirate*, so `pirate.json` is fine for this guide.

### Windows
```cmd
cd lua/loc/
copy en.json pirate.json
```

### Linux
```bash
cd lua/loc/
cp en.json pirate.json
```

## Including your translation

To include your translation in the list, you'll need to add it to `/lua/RWN.lua`.

```lua
Hooks:Add("LocalizationManagerPostInit", "RWNLoc_LocalizationManagerPostInit", function(loc)
    local current_language = nil
    local supported_languages = {
        ["chinese"] = "zh",
        ["german"] = "de",
        ["english"] = "en",
        ["spanish"] = "es",
        ["french"] = "fr",
        ["italian"] = "it",
        ["russian"] = "ru",
        ["thai"] = "th",
    }
```

You need to modify that piece of code to include your language:

```lua
Hooks:Add("LocalizationManagerPostInit", "RWNLoc_LocalizationManagerPostInit", function(loc)
    local current_language = nil
    local supported_languages = {
        ["chinese"] = "zh",
        ["german"] = "de",
        ["english"] = "en",
        ["spanish"] = "es",
        ["french"] = "fr",
        ["italian"] = "it",
        ["russian"] = "ru",
        ["thai"] = "th",
        ["pirate"] = "pirate",
    }
```

Just add yours in a similar fashion to the existing translations, save your changes, and close `/lua/RWN.lua`.

That's it.

## Actually translating content

Go back to your file, `/lua/loc/pirate.json`.

Open the translation file you created in `/lua/loc/`.
You should see something like: 

```json
"bm_melee_pugio_info" : "This is a knife designed and used for killing.",
```

Now you just need to work through this file, updating the strings like so:

```json
"bm_melee_pugio_info" : "This here be a dagger designed an' used fer killin'.",
```

It's important that you modify just the string, and not the variable name which is used to access its content.
For example, changing `bm_melee_pugio_info` to `bm_melee_knife_info` would make the translated string inaccessible to the mod.

If a variable is not found in your translation, the default English version of that variable will be used. This is to make sure that names and other elements are not empty.

## Verifying your translations

It's advisable to save your translation file frequently, and open PAYDAY 2 to check that there are no errors in your translation file.
If there are any errors inside the JSON file, it will fail to parse, and the string will not load or the game will crash if you forgot to add commas, quotation marks or quotation marks are not escaped correctly.

```json
"escape_example" : "Escape quotation marks inside a string \"LIKE THIS\" or the game will crash.",
```

Checking frequently will make it easier to know which change caused the error or the crash.

## Getting Help

If you have any issues, [open an Issue](https://github.com/Strappazzon/PD2-Real-Weapon-Names/issues/new) here on GitHub or leave a comment [on Mod Workshop](https://modwork.shop/19958).
