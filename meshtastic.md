---
layout: default
title: "Meshtastic: text messages without phones or the internet"
permalink: /radio/meshtastic/
---

# Meshtastic: text messages without phones or the internet

Meshtastic lets you send text messages to other people nearby when there is no mobile signal, no wifi and no internet. It uses small, cheap radio devices that run for days on a battery, and every device helps pass messages along. With enough devices spread across a neighbourhood, a town can build its own text message network that keeps working when everything else is down.

## How it works

- **LoRa radio.** Each Meshtastic device has a LoRa radio. LoRa (short for "long range") sends small amounts of data over long distances using very little power. It cannot carry voice or pictures, but it is ideal for short text messages.
- **Your phone is the keyboard.** You pair a device with your phone over Bluetooth and use the free Meshtastic app to write and read messages. The phone does not need a signal. Some devices have their own screen and keyboard, so they work without a phone at all.
- **A mesh of relays.** When your device receives a message, it repeats it so that devices further away can hear it too. By default a message can be passed on up to three times. This is what makes it a "mesh": the more devices there are, the further and more reliably messages travel.
- **Channels.** Messages go out on a channel. Everyone with Meshtastic can read the default public channel, which is useful for sharing news widely. You can also set up your own private channel, protected by encryption, for your group or street.

## Why it suits an emergency

- **Very low power.** A small device can run for days, or weeks if set up carefully, on one battery. A small solar panel can keep it going indefinitely.
- **Cheap.** Ready-made devices cost from about £25 to £80.
- **No licence needed.** In the UK, Meshtastic devices set to the UK and Europe region (EU_868) use a licence-free band, with limits on power and on how often each device can transmit. Leave the region and power settings at the recommended values.
- **Range.** Between two devices at ground level in a town, expect a few hundred metres to a mile or two. Placed high up, on a roof, a hill or a tall building, a device can reach many miles, and relay messages for everyone below.
- **It keeps a written record.** Unlike voice radio, everyone can scroll back and read exactly what was said, which helps stop messages being misheard or changed as they pass along.

## Coordinating action and stopping rumours

A local Meshtastic network can be one of the most useful tools a community has in a crisis. It can be used to:

- coordinate volunteers, such as who is checking on which streets;
- share where water, food, warm spaces or medical help are available;
- pass on official advice word for word, so it does not get twisted as it spreads; and
- check rumours quickly, by asking people in the area what is actually happening.

Because messages reach many people at once and are written down, a calm, accurate message can travel as fast as a rumour. That makes it a good place for peacemakers to be present (see below).

## Getting started

1. **Buy two devices,** so you can test them together. Choose ones listed as supported on the Meshtastic website and sold for the 868 MHz band.
2. **Install the Meshtastic app** on your phone and pair it with a device.
3. **Set the region to EU_868.** This is required for legal use in the UK.
4. **Find your local mesh.** There may already be people using Meshtastic near you. Check the public channel, or look for a local group online.
5. **Put a device up high.** A device in a loft window or on a roof, with a battery and solar panel, can serve your whole street.

<p class="notice">Some devices share your location on the map by default. If you do not want people to see where you live, turn off location sharing, or set a fixed position somewhere public, before you join a mesh.</p>

## Privacy

Messages on the default public channel can be read by anyone with Meshtastic. Use a private channel for anything you would not say in public, and still never send passwords, door codes or details of when a house will be empty.

{% include peacemakers.html %}

## Useful links

- [Meshtastic](https://meshtastic.org/), the official website, with guides, supported devices and the apps.
- [Meshtastic documentation](https://meshtastic.org/docs/), for detailed setup and settings.

<p class="soon">More guides coming soon, including building a solar-powered relay.</p>

See [Further reading](/further-reading/) for more websites and books.

{% include help-wanted.html %}
