# Vesta wallet

Light and simple cryptocurrency wallet.

## Motivation

While a number of 3rd party mobile wallets do support Peercoin, there is a growing concern that such services could hold the community in ransom and ask for payments in order to keep Peercoin integrated with their services. Members of the Peercoin community have proposed a simple and light architecture for a mobile wallet based on Flutter technology. The codename is Vesta, Vesta is the brightest asteroid visible from Earth.

While Peercoin is the main focus of the effort, Vesta will accept PR's to support other coins - notably Bitcoin and coins based of Bitcoin. Given that maintnance of those will not take too much time and effort.

## Architecture

### Backend

First iteration is to use ElectrumX backend, which is fairly popular solution for light wallets.
Long term backend is not yet decided, one of the options is [multichain](https://github.com/renproject/multichain) by Ren Project.

### Frontend

Modern UI implemented in Flutter, deployed on three platforms: Android, iOS and web.
