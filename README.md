# TabManager
What is `tab_manager` about?

Well, it's easy, this is a tab manager. Imagine, you have a bigger group at an event, like a camp.
From year to year, the attendance of these events increased, and the administration cost of the open
buffet increased at least twice the volume.

Outside of the paperwork, the `paper` is another problem.
Mostly because it is not redundant, and highly...

... well, vulnerable :-)

## The Concept
One of the solutions is to put these notes to the cloud, backed by user devices, so the data is kind
of distributed, and easily manageable.
So the idea was to use smartphones because everybody has at least one in their pocket.

## Technical details
The project is strongly in the development phase. We use `Flutter` and at the moment `AWS Ampify`.
There is an intention to go in a cloud-agnostic manner, but that's not the priority yet.

Basically, you can use this repository to create your own backend, so you can scan the connection
data with the official app, or you can simply just compile your own client too.

### Build your own backend
Due to Amplify's stupid behaviour, the following steps are required to install your own backend:

 - Go to the `Amplify` in the `AWS Console`
   * Create new app, name it, launch `Studio`
 - Go to your `Terminal` and pull the new empty backend:
   * run `amplify pull --appID <appid by the studio> --envName <env name by the studio>`
   * it will ask a few things, default is usually good
   * important is that you want to modify the backend, so press `Y` there
- Add the authentication plugin:
   * run `amplify add auth`
   * default config is okay
   * `Email` is okay
   * no advanced settings
 - Add API plugin:
   * run `amplify add api`
   * choose `GraphQL`
   * authorization should be set to `Cognito`
   * it will ask for additional types, press `No`
   * conflict detection should be enabled and set to `Auto Merge`
   * press `Continue`
   * it will ask about schema, choose `Blank Schema`
   * it will ask that you wanna edit the schema, do so
   * copy the contents of the [Schema](#schema) section and save it
 - Create the backend:
   * run`amplify push`
   * it will ask for a description, write `default`
   * it will ask for API key expire, set it to `365`

Of course you can select different options, but this is the tested way.

### Schema

```graphql
type Stock @model
  @auth(rules: [{allow: private, operations: [read]}, {allow: groups, groups: ["Admin"]}]) {
  id: ID! @primaryKey
  amount: Int!
  supply_price: Int
  supply_time: AWSDateTime
  product: Product! @belongsTo
}

type Product @model
  @auth(rules: [{allow: private, operations: [read]}, {allow: groups, groups: ["Admin"]}]) {
  id: ID! @primaryKey
  name: String!
  unit_price: Int!
  event: Event! @belongsTo
  stocks: [Stock] @hasMany
  consumptions: [Consumption] @hasMany
}

type Event @model
  @auth(rules: [{allow: private, operations: [read]}, {allow: groups, groups: ["Admin"]}]) {
  id: ID! @primaryKey
  name: String!
  start_date: AWSDate!
  end_date: AWSDate!
  products: [Product] @hasMany
}

type Consumption @model
  @auth(rules: [{allow: private, operations: [read]}, {allow: groups, groups: ["Admin"]}, {allow: owner}]) {
  id: ID! @primaryKey
  product: Product! @belongsTo
  amount: Int!
  time: AWSDateTime!
#  owner: String!
}
```

### Create backend connectors
After [backend setup](#Build your own backend) go to the terminal, and check if your
`lib/amplifyconfiguration.dart` is up to date with your backend's credentials. If not, then run:
`amplify pull`, and now you can run:

```bash
flutter pub get
flutter pub run lib/commands/create_qr_backend.dart
```

It will create a QR code and a connection string. Test both if they are working ;)

### Build your own client
Currently not so much, but do not forget to generate the icons, if you have modifications :)

```bash
flutter pub get
flutter pub run flutter_launcher_icons:main
flutter build
```

If you overwrite the `lib/amplifyconfiguration.dart` with your own generated one,
the backend QR screen will be skipped.

## Known bugs
With the local data / backend config deletion and logout process the states are mixed up.
