---
layout: project
title: "Re-Imagining a FOSS Habbo + ICQ in 2025"
---




# Re‑Imagining a FOSS **Habbo + ICQ** in 2025

\### Low‑Bandwidth Graphics • Peer‑to‑Peer Networking • Zero Central Servers

---

## 1 Historical Inspirations

### 1.1 MyCoke Studios (2002 – 2007)

| Aspect             | What It Was                                                                      | Why It Worked on 2000‑era Links                                   |
| ------------------ | -------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| **Genre**          | Branded social‑virtual world (isometric rooms, avatar chat, in‑game music mixer) | Filled the gap between plain IM and heavy MMOs.                   |
| **Tech**           | Shockwave/Flash vectors + fixed 256 × 256 pixel tiles                            | *Tiny* payloads; once cached locally, assets never re‑downloaded. |
| **Currency & UGC** | “Decibels” earned via mini‑games and audience votes; users decorated rooms       | Loop kept teens coming back despite dial‑up speeds (< 56 kbps).   |
| **Marketing Hack** | Coke bottles & TV spots pointed teens online                                     | Built‑in audience; piggy‑backed on Coca‑Cola’s reach.             |

*Lesson →* **Vector art + modular tiles + cleverly cached assets can deliver a rich world with minimal bandwidth.**

---

### 1.2 Habbo Hotel (2000 – Present)

| Aspect           | Details                                                                        |
| ---------------- | ------------------------------------------------------------------------------ |
| **Engine**       | Sulake’s “FUSE” pixel‑perfect isometric renderer (Flash, later Unity / WebGL). |
| **Interaction**  | All state changes were *delta* messages: “avatar A walks to tile (5,9)”.       |
| **Monetisation** | Selling furniture (furni) + hotel‑wide events.                                 |
| **Culture**      | Simple rooms + low barrier to entry → endless emergent play.                   |

*Lesson →* **Transmit *state*, not bitmaps.** Graphics live client‑side; the wire only carries events.

---

### 1.3 ICQ (1996 – 2003 peak)

| Feature                      | Ground‑breaking Idea                        | Bandwidth Impact                            |
| ---------------------------- | ------------------------------------------- | ------------------------------------------- |
| **Presence**                 | “Uh‑oh! ☻ CJ is online”                     | Text‑only packets; near‑zero cost.          |
| **User ID**                  | Self‑assigned numeric UIN (public‑key‑ish)  | Removed e‑mail dependency; simplified auth. |
| **Push, not Poll**           | Client maintains socket; server pushes msgs | No busy‑waiting HTTP polling.               |
| **File xfer & Chat history** | Optional, on‑demand                         | Heavy data only when requested.             |

*Lesson →* **Push‑based sockets + plain‑text protocols were instantly addictive and efficient.**

---

## 2 Why Tor + IPFS Are Game‑Changers

| Challenge (90s/00s)     | Tor Hidden Services • IPFS Content Addressing                                                          | Outcome                                        |
| ----------------------- | ------------------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| **NAT traversal**       | `.onion` endpoints route traffic through Tor relays; no port‑forward/ICE needed.                       | Every peer reachable from anywhere.            |
| **DNS / identity**      | Onion addresses *are* public‑key hashes; IPNS/ENS add friendly names.                                  | No central DNS, spoof‑proof IDs.               |
| **Server costs & DDoS** | No origin server—each peer can host itself.                                                            | Costs drop to zero, attack surface shrinks.    |
| **Asset delivery**      | IPFS deduplicates & pins vector assets; peers fetch from the mesh even while original host is offline. | Infinite “seeders,” instant patch roll‑outs.   |
| **Privacy**             | Tor encrypts links + hides IP; IPFS hashes reveal no metadata about requester.                         | Users stay pseudonymous; location untraceable. |

---

## 3 Modernising the Graphics & Protocol

### 3.1 Client‑Side Rendering Stack

| 90s/00s Piece | 2025 FOSS Equivalent                      | Why This Choice                               |
| ------------- | ----------------------------------------- | --------------------------------------------- |
| Flash/SWF     | **SVG + Web Components**                  | Native, vector, CSS‑styleable, no plugins.    |
| Bitmap tiles  | **CSS Grid layers** or **WebGL quads**    | GPU‑accelerated, retina‑ready.                |
| ActionScript  | **JavaScript / WebAssembly**              | Wide talent pool, sandboxed.                  |
| MovieClips    | **Declarative components (Lit / Svelte)** | Incremental DOM diffing = tiny state patches. |

#### Seed‑Driven Procedural Assets

Transmit just a `seed + version`. Each client locally generates an avatar or decor item identically—zero bandwidth afterward.

---

### 3.2 Push‑Based Event Fabric

* **Event Channel**: Libp2p Gossipsub over Tor.
* **Data Model**: CRDT (`Automerge`) → resist conflicts when offline.
* **Auth**: Ed25519 keys behind `.onion`; actions signed & verified.

#### Event Lifecycle:

1. User moves chair → local CRDT patch.
2. Patch signed with user key → PubSub broadcast.
3. Peers validate signature → merge patch → re‑render.
4. If patch references unseen asset hash, peer fetches via IPFS automatically.

---

## 4 Blueprint — “HabboICQ P2P”

| Layer                    | Tech                                 | Notes                            |
| ------------------------ | ------------------------------------ | -------------------------------- |
| **Identity**             | Tor .onion (self‑auth) + DID/UCAN    | Portable wallet of capabilities. |
| **Transport**            | Tor socks5 + Libp2p                  | NAT‑agnostic, anonymous.         |
| **Messaging / Presence** | Libp2p PubSub topics per friend/room | Push only.                       |
| **World State**          | Automerge (binary)                   | Delta‑encoded, encrypted.        |
| **Assets**               | IPFS (SVG bundles, audio samples)    | Pin by community “guild” nodes.  |
| **Client**               | Browser/Electron; SVG+WebGL renderer | 100 kb baseline payload.         |

---

## 5 Key Lessons Rolled into Recommendations

| Historical Insight                     | Modern Implementation                                                       |
| -------------------------------------- | --------------------------------------------------------------------------- |
| Vectors over bitmaps = slim downloads  | **SVG symbol libraries** + CSS theming                                      |
| Cache everything client‑side           | IPFS pinning & browser storage                                              |
| Event‑only sockets (Habbo deltas)      | CRDT delta wire‑format                                                      |
| Push beats poll (ICQ presence)         | Libp2p Gossipsub topics                                                     |
| Self‑authenticating IDs (UIN / .onion) | Tor addresses + DIDs                                                        |
| Marketing network effect (MyCoke)      | Community pin‑servers seed assets; social media *optional* but not required |
| Protect users in hostile nets          | Tor for path‑level anonymity; content encryption end‑to‑end                 |

---

## 6 What the User Sees in 2025

*Download‑less URL*: `https://p2photel/#/?gateway=tor`

* First load: \~200 kB (engine + minimal SVG set)
* From then on: < 1 kB/min typical chat & movement traffic
* Works behind CG‑NAT, corporate firewalls, or in a mesh island with zero internet—just Tor bridges & IPFS peers.

Features delivered **without any central server**:

* Pixel‑perfect isometric hotel, fully community‑hosted
* Rich text/voice chat (optional WebRTC over Tor)
* Drop‑in music mixer (WebAudio) with sample packs pinned to IPFS
* Persistent rooms & inventories tied to user’s keypair
* Client‑side mods & themes (fork‑friendly)

All while remaining **private, censorship‑resistant, offline‑tolerant, and virtually free to host**.

---

## 7 Factorio‑Style Logic & In‑Game Workspaces

A transformative layer for this virtual world is the addition of **Factorio‑style modular logic systems**, enabling players to build not just spaces but **functional, programmable workflows** within the environment.

### Concept: Social ComfyUI in an Isometric World

* **Users place and connect logic blocks** like sensors, feeds, triggers, and outputs.
* These blocks could read RSS feeds, analyze sentiment or metrics, and perform real‑world actions (send messages, call webhooks, update dashboards).
* Objects are visually and functionally linked: like a comfyUI graph or factorio conveyor chains.

### Example Use Case:

1. A player places a "RSS Feed Reader" object.
2. They connect it to a "Sentiment Analyzer" node.
3. This outputs to a "Message Generator" or "Webhook Caller".
4. The final node sends alerts to a room, user, or external system.

### Features Enabled:

* Visual scripting in‑world: **logic chains built collaboratively**.
* Integration with **real‑world data sources**.
* In‑game creation of **tools, bots, alert systems, dashboards**.
* **Forkable and shareable logic constructs** as modular items or templates.

### Technical Implementation:

* Each logic block is a **WebAssembly sandbox** or **local plugin**.
* **IPFS-pinned logic templates** can be shared across peers.
* Logic execution and state handled client-side with CRDT outputs to other blocks.
* **Trigger flow**: RSS block updates → analyzer block runs NLP → output block triggers action.

This elevates the platform from a space for interaction into a **fully programmable social computing environment**: community‑run, modular, and integrated with external information flows.

---

**End of Document**
