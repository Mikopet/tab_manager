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
data with the official app, or you can simply just compile your own application too.

For creating the backend you should run `amplify push` with your own credentials.

### Build steps
Currently not so much, but do not forget to generate the icons :)

```bash
$ flutter pub run flutter_launcher_icons:main
```

If you overwrite the `lib/amplifyconfiguration.dart` with your own generated one,
the backend QR screen will be skipped.
