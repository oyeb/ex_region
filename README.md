# `ExRegion`

The smart and fast way to work with ISO 3166 countries and subdivisions, on
`*nix` systems in Elixir.

This library depends upon the widely available `pkg-isocodes` linux
package. Most linux distros depend upon the famous Debian
[iso-codes][debian] repo for this.

Your distro might call this package something else, so here's a handy list of
links.

[Arch][arch]
Ubuntu
Fedora

<!-- start links -->

[arch]: https://www.archlinux.org/packages/extra/any/iso-codes/

<!-- end links -->

> And, please help me add links for other distros, I'm a lazy human!

## Inspiration

I'm not a genius, I found this is how
[`pycountry`](https://bitbucket.org/flyingcircus/pycountry/) does it.
Then, <kbd>ctrl+c</kbd> <kbd>ctrl+v</kbd>

## FAQ

### Why another lib? How's this any better from others?

Here's a list of alternative libraries:

* [countriex](https://github.com/navinpeiris/countriex)
  - Only country data :-1:
  - Very low maintenance as it simply pulls data from the ruby
    [countries](https://github.com/hexorx/countries) gem.
  - Still, the regeneration task has to be run manually.
* [Countries](https://github.com/SebastianSzturo/countries)
  - Has both country and subdivision data :+1:
  - Very high maintenance as it brings all the data along as `YAML`. :-1:
  - `YAML` parsing is soooooo slow :angry: (too many files, parse done
    serially... it's YAML what do you expect?)
* [Worldly](https://github.com/vinsol/worldly)
  - Very high maintenance as it brings all the data along as `YAML`. :-1:
  - `YAML` parsing is soooooo slow :angry: (they even accept it on their
    README).

I have two unbeatable arguments _for_ `ExRegion`,
1. Speed
   - Parse just two `JSON` files (< 500KB) using [`jason`][jason].

2. Free maintenance
   Yes, I have my cake and eat it too. Thanks to the awesome team that maintains
   the [upstream debian repo][debian], and people at ISO.

   > If you ever notice that the standards got updated, simply upgrade your
   > `iso-codes` package!

### How do I check if my system has this `iso-codes` package?

Easy, just see if there's something at `/usr/share/iso-codes/json/`.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exregion` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exregion, "~> 0.1.0"}
  ]
end
```

## TODO

The goal is primarily speed and leveraging commonly available linux packages.

* So the [debian repo] exposes many ISO standards, and even translations in
  almost every locale. Wouldn't it be nice if we can get all that?
* Some cool functions to group or filter things?
* **Time zone info**
* Tests.
* Integrate with CLDR? There are already some repos in the Elixir world like
  [money](https://github.com/kipcole9/money) -- don't wanna compete with them.
* Geo and topological information?
* Demographics?

[debian]: https://salsa.debian.org/iso-codes-team/iso-codes
