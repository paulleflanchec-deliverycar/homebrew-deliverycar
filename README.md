# homebrew-deliverycar

Tap Homebrew Delivery Car pour installer rapidement les outils par profil.

## Formules disponibles

1. `delivery-car-setup`
Description: setup environnement DEV.
Apps installées:
- `visual-studio-code`
- `slack`
- `google-chrome`
- `insomnia`
- `figma`
- `notion`
- `docker`
Dependencies:
- `git`
- `node`

2. `delivery-car-setup-ops`
Description: setup environnement OPS.
Apps installées:
- `aircall`
- `slack`
- `google-chrome`
Installation complémentaire:
- monte le DMG d’un driver imprimante
- installe un `.pkg` trouvé dans le volume monté

## Prérequis

- macOS
- [Homebrew](https://brew.sh/)
- droits admin macOS (requis pour `delivery-car-setup-ops` car `sudo installer` est exécuté)

## Installer le tap

```bash
brew tap paulleflanchec-deliverycar/homebrew-deliverycar https://github.com/paulleflanchec-deliverycar/homebrew-deliverycar.git
```

Nom de tap utilisé ensuite par Homebrew:
- `paulleflanchec-deliverycar/deliverycar`

## Installer le setup DEV

```bash
brew install paulleflanchec-deliverycar/deliverycar/delivery-car-setup
```

## Installer le setup OPS

```bash
brew install paulleflanchec-deliverycar/deliverycar/delivery-car-setup-ops
```

## Structure du repo

- `Formula/delivery-car-setup.rb`
- `Formula/delivery-car-setup-ops.rb`
- `assets/` (assets utilisés par les formules)

## Driver imprimante OPS

La formule OPS attend le fichier:
- `assets/drivers/MX-C52d_2111a_MacPS.dmg`

Comportement de la formule:
1. monte le DMG avec `hdiutil`
2. cherche le premier `.pkg`
3. lance `sudo installer -pkg ... -target /`
4. démonte le volume

## Dépannage

### Erreur `Expected to find class DeliveryCarSetup, but only found: ...`

Cause: le nom de classe Ruby ne correspond pas au nom du fichier de formule.

Règle Homebrew:
- `Formula/delivery-car-setup.rb` doit contenir `class DeliveryCarSetup < Formula`
- `Formula/delivery-car-setup-ops.rb` doit contenir `class DeliveryCarSetupOps < Formula`

### Erreur `No available formula with the name "...delivery-car-setup-ops"`

Points à vérifier:
- la formule est bien dans `Formula/delivery-car-setup-ops.rb`
- le tap local est à jour

Commandes utiles:

```bash
brew untap paulleflanchec-deliverycar/deliverycar
brew tap paulleflanchec-deliverycar/homebrew-deliverycar https://github.com/paulleflanchec-deliverycar/homebrew-deliverycar.git
brew search paulleflanchec-deliverycar/deliverycar
```

### Erreur `Driver DMG not found`

Cause: le fichier DMG est absent ou pas au chemin attendu.

Vérifier la présence du fichier:

```bash
ls -lah assets/drivers/MX-C52d_2111a_MacPS.dmg
```

### Validation syntaxe des formules

```bash
ruby -c Formula/delivery-car-setup.rb
ruby -c Formula/delivery-car-setup-ops.rb
```

## Désinstaller

```bash
brew uninstall delivery-car-setup delivery-car-setup-ops
brew untap paulleflanchec-deliverycar/deliverycar
```
