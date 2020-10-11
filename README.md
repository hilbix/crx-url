> I consider it very evil that Google does not provide a direct download link for Chrome Extensions on their Webstore
> nor proper documentaion of the CRX3 file format.


# Display proper `wget` command to download a CRX file

This is a simple and scriptable way to get a download URL of Google Chrome CRX files (AKA Chrome Extensions).

Based on https://stackoverflow.com/a/14099762

> **Warning!** There are several websites which allow to download things.
- Never trust external sites, they might do very nasty things to your computer.


# Usage

	git clone https://github.com/hilbix/crx-url.git
	crx-url/crx-url.sh -help

Example direct use:

	crx-url/crx-url.sh '' https://chrome.google.com/webstore/detail/new-tab-aboutblank/oajnkblmghobfiaoblpcnffdiecocgnl

Example how to automate download:

> Warning!  Following example overwrites the (calculated) destination `.crx`-file unconditionally if it exists!  No backup done!

	cmd="$(
	crx-url/crx-url.sh '' https://chrome.google.com/webstore/detail/new-tab-aboutblank/oajnkblmghobfiaoblpcnffdiecocgnl
	)" && $cmd


# FAQ

License?

- Free as in free beer, free speech and free baby.

chrome-version?

- See "About Google Chrome" (from where it updates).  Copy the dotted version from the first to the last number.
- For missing versions (`crx-url.sh ''`) it tries to read the version from the installed Debian package but falls back to some historic version.

Why no automatic download by default?

- Because I like to modify the command first, for example to extract CRX2 only

Why `wget`?

- I'm just too lazy

Unpack CRX?

- `file=(*.crx) && unzip "$file"` is your friend (this assumes `/bin/bash` as your shell)
- You can ignore the `unzip` warning that it skipped something.  This is the signature header of CRX files

Check CRX?

- Perhaps see
  - https://github.com/vladignatyev/crx-extractor
  - https://stackoverflow.com/a/59009114
  - https://groups.google.com/a/chromium.org/forum/#!topic/chromium-extensions/XvddmJZvGIY
  - https://web.archive.org/web/20180114090616/https://developer.chrome.com/extensions/crx
  - https://github.com/pawliczka/CRX3-Creator
- Note:  Never trust downloads from foreign sites.  Always check the source, Luke!

Windows?

- [WSL](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)!

