# homebrew-awless
Brewfile for awless

## Updating brew formula and bottle

1. Uninstall brew awless

    brew uninstall awless
    
2. Update [formula](https://github.com/wallix/homebrew-awless/blob/master/Formula/awless.rb) with new version informations
3. Build bottle

    brew install --build-bottle awless
    brew bottle awless
    
4. Update the formula with the output of `brew bottle...` (for example)

    bottle do
      cellar :any_skip_relocation
      sha256 "b57ebf0c0374cd9fdc7486956d6f5bf0a932a36e91c3d4bd2ee4fd09d021b763" => :sierra
    end

5. Push the formula
6. Add the formula to a new release on github releases of homebrew-awless