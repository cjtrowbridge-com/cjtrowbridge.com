---
layout: project
title: "GS-Aparat"
blurb: Comprehensive Specification for Web-Based Composable Logic App
---

## GS-Aparat

*Comprehensive Specification for Web-Based Composable Logic App*

### 1. Application Overview
  The application is a web-based, visual programming environment designed around the metaphor of "rooms" and "workers" to represent composable logic blocks. It leverages nested, hierarchical structures allowing users to create flexible logic, processes, and complex analyses visually, including optional AI-assisted tasks. The environment combines principles from functional programming and von Neumann architectures, enabling both stack-based processing and asynchronous message passing via couriers.  
### 2. Key Concepts  

a. Hierarchical Metaphor  
    - **World**: Represents the entire logical or computational space.  
    - Mario-style map showing simple network of routes between nodes representing regions.  
- **Regions**: Logical groups of Towns where related logics occur.  
    - Mario-style map showing simple network of routes between nodes representing towns/cities.  
    - A desert, a forest, etc containing some number of crude settlements which can be improved into towns and cities.  
    - The view of the town/city/settlement should be a cluster of tiles showing each unique building type.  
        - For example, a simple settlement is just a tent surrounded by the region's landscape. A city might contain many warehouses, homes, offices, workshops, factories, and one of each unique building should be represented as tiles in a cluster around that node in the network, surrounded by the region's landscape. So a settlement is just a tent next to the node, a city is many unique tiles surrounding the node.  
 - **Towns/Cities/Settlements:** Logical groups of buildings containing rooms.  
    - This is more like SimCity 2000/3000; a grid of the region's landscape containing buildings and paths/roads. Buildings need access to paths/roads. Paths happen automatically to connect buildings to the regional network.  
    - Building more fancy buildings converts their route to the regional network to roads.  
 - **Buildings:** a home, an office building, a factory, a warehouse.  
    - Players start with access to basic, simple homes and unlock more complex logic in the form of factories housing complex machinery and eventually automation tools like robots.  
    - Libraries and warehouses represent memory, storing and retrieving information.  
        - SQLite3, MySQL, Postgres, file stores, etc.  
        - Advanced robotic storage and retrieval warehouses may represent H2, REDIS, etc  
        - Cities and towns also contain buildings which do not contribute to logic, but improve quality of life. For example, a cute cafe or pub on the corner to add character to the neighborhood.  
    - **Rooms**: Basic composable logic units, each containing one or more worker NPCs.  
        - NPCs engage in leisure, watching tv or sleeping when they have nothing to do.  
        - Animals like cats wander around, interacting with NPCs  
    - **Distant Lands:** Couriers traverse the road networks, coming and going to and from distant lands off the edge of the map. These journeys represent rss feeds, emails, webhooks, api calls, search results, etc.  
b. Workers (NPCs)  
    - Perform task as defined on the whiteboards in the rooms they are in.  
    - Visually represent system states (idle, busy, error).  
c. Whiteboard (Flowchart Logic)  
    - All rooms have a whiteboard outlining instructions using a simple flowchart, but some rooms have different instructions available depending on the system services associated with the space.  
        - A home office might have instructions for analyzing sentiment of incoming mail and sending results somewhere, leveraging LLMs. Storing and retrieving things there might be messy and slow.  
        - A warehouse might have instructions for several workers to accept storage requests and put things on their many shelves, or retrieve things as requested. (This represents database or file system interactions.)   These workers might store and retrieve things quickly but be unable to perform sentiment analysis using LLMs. Robotic storage and retrieval might work even faster once unlocked.  
    - Each room's whiteboard flowchart nodes represent the logic governing the worker(s) in the room (conditionals, routing, AI-tasks).  
    - Skills can be unlocked as tools are detected on the local network (e.g., local Ollama Docker).  
d. Message Passing  
    - Inputs and outputs represented by mail slots.  
    - Couriers visually move data/messages between rooms/buildings/towns/regions/etc.  

### 3. Technology Stack
- **Backend**: Java with a simple dashboard giving details about the state of the running "world" and its users and workloads.
- **Frontend**: Web-based tile RPG with those five different level views:
    - World: mario-style network of regions
    - Region: network of towns/cities/settlements with a particular landscape (desert, grass, etc) plus connections off the map to adjacent regions
    - Towns/cities/settlements: city grid of landscape with connections to the regional road network off the edge of the map. Buildings can be built, connecting automatically to the road network. Buildings must have access to the road network. Some fancier buildings cause paths to convert to roads between the building and the regional network off the edge of the map.
    - The default version of all the views is simply read-only observation. When anyone opens the url, it shows them the world. They can click click into regions, and then click into towns, and click into buildings, into homes, and even click into the whiteboards in the rooms or observe the interactions between npcs as they conduct their work.
    - All behavior of all entities and npcs across the entire world are deterministic based on the inputs into the world.
    - Couriers are bringing things into the world and dropping them through mail slots into queues. This means all of those future steps are known.
    - Having access to the entire current state of the world is all the ui needs from the server, and then it can draw out everything that's happening in real time, updating based on changes to the state as relayed by the server, because all behavior is well understood and predictable based on the inputs. And the ui only needs to draw whatever the user is actually looking at.
    - This enables a very minimal amount of data to encode the entire state of the entire world. This is a core requirement so that massive multiplayer games involving extremely complex logic are possible.
- **Data Persistence**: SQLite or PostgreSQL for simple state persistence.
- **Containerization**: Docker for easy deployment and dependency management.

### 4. System Architecture

#### Backend Architecture
- RESTful API to handle CRUD operations for worlds, regions, towns, buildings, rooms, and logic definitions.
- Worker process simulation using Java concurrency features.
- Automatic detection and conditional integration with external services (e.g., local Ollama Docker API).
- Simple administrative dashboard providing state information and workload analytics.
- Support for hybrid functional and von Neumann computing styles (stack-based processing and courier message passing).

#### Frontend Architecture
- Interactive graphical web UI visualizing hierarchical levels: worlds, regions, towns/cities/settlements, buildings, and rooms.
- Drag-and-drop functionality for constructing and editing the hierarchical structure and logic flowcharts.
- Dynamic zoom and navigation between hierarchical levels with intuitive UI transitions.

### 5. Core Features

#### a. Rooms as Logic Blocks
- JSON representation of logic blocks stored persistently:

```json
{
"id": "room-1",
"name": "Sentiment Analysis",
"inputs": ["inbox"],
"outputs": ["analytics", "general"],
"instructions": [
{"condition": "document.type == 'Review'", "action": ["ai.sentiment", "send sentiment_score analytics"]},
{"condition": "else", "action": ["forward general"]}
],
"workers": [{"id": "worker-1", "state": "idle", "skills": ["basic-routing", "ai-sentiment"]}]
}
```

#### b. Dynamic Whiteboard Logic
- Logic flowcharts editable and visually represented, stored as structured JSON:

```json
[
{"type": "if", "condition": "input.a == true", "then": ["send output to B"], "else": ["send output to C"]}
]
```

#### c. AI Integration (Conditional)
- Backend conditionally detects local Ollama Docker instances and dynamically exposes REST endpoints for AI tasks.

#### d. Workers (NPCs)
- Workers represent the action of a function as defined by the scope of a room and the logic of a whiteboard. Think of workers as program counters moving through the logic and doing the work of executing the function. 
- When they don't have anything to do, they engage in leisure.

#### e. Whimsical and Non-Functional Elements
- Inclusion of purely whimsical buildings for fun and quality-of-life enhancements, such as parks, cafes, pet stores, gardens, or amusement attractions.
- These buildings visually enrich the environment without impacting computational logic or functionality.

### 6. User Interface Design

#### a. Hierarchical Visualization
- Nested UI allowing intuitive navigation between worlds, regions, towns, buildings, and rooms.
- Detailed visualizations displaying internal logic states, worker actions, and message flows.

#### b. Interactive Elements
- Drag-and-drop editing of structures and logic.
- Dynamic visualization of courier messages.

### 7. Extensibility & Customization
- Easily configurable JSON schemas to allow custom user-defined room types, building types, and logic workflows.
- Plugin architecture enabling extended functionality and integration with additional services.

### 8. Implementation Roadmap
    1. **Project Setup**:
        - Java/Spring backend initialization, database configuration, basic REST APIs.
    2. **Basic Hierarchical Functionality**:
        - Implementation of world, region, town, building, and room CRUD APIs.
    3. **Worker and Logic Simulation**:
        - Concurrency and asynchronous processing of workers based on whiteboard logic.
    4. **Message Passing System**:
        - Backend logic for efficient message handling between hierarchical components.
    5. **Whiteboard Logic Editor**:
        - Visual editor development for flowchart-based logic editing.
    6. **Conditional AI Integration**:
        - Dynamic backend integration with Ollama Docker APIs.
    7. **Hierarchical UI Navigation**:
        - Comprehensive interactive frontend for navigating and managing hierarchies.
    8. **Deployment & Containerization**:
        - Full Dockerization and simplified deployment through Docker Compose.

### 9. Lore and Background
    - The lore is that after the world collapsed in the early 2000s, the oligarchy built a kleptocracy. 
    - In the 2030s, disasters mounted and chaos spread. The klept was overthrown. The proletariat killed all the oligarchs and billionaires.
    - The new global soviet system emerged to ask everyone to do small tasks in exchange for having all their basic needs met.
    - The New New Deal of the global Soviet Aparat is that workers enjoy cozy cottagecore and solarpunk lives of leisure, doing some small task for the global soviet aparat as needed in exchange for having all their basic needs met.

#### Relationship Characterization
    - Mutual Pact, not Coercion - The Apparát is seen as a benevolent caretaker; workers view small tasks as community upkeep rather than labor exploitation.
    - Predictability = Security - Because the simulation is deterministic, NPCs trust the Apparát's schedules: no surprise shortages, no hidden quotas.
    - Cottagecore + Solarpunk Aesthetic - Wooden textures, gardens full of pollinators, soft lighting, reclaimed-tech art pieces reinforce psychological comfort.

How This Enhances Gameplay
    - Emotional Connection - Players empathize with NPCs enjoying visible perks (banya steam, cat cuddles).
    - Clear Utility of "Useless" Buildings - Although cafés and bathhouses don't change logic throughput, witnessing their effect on NPC morale adds delight.
    - Lore-Driven Determinism - The Central Plan justifies why every parcel route and worker routine is pre-known: it's not a limitation, it's ideological consistency.
    - Upgrade Motivation - Unlocking new green tech (e.g., algae bioreactors) visibly improves worker well-being, giving players a satisfying feedback loop between logic progression and social prosperity.

This framing keeps the focus on what workers gain while embedding the deterministic courier-logic core inside a hopeful, post-collapse solarpunk-Soviet utopia.

