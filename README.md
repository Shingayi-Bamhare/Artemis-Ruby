Artemis Ruby
============

A Ruby port of [Artemis](http://gamadu.com/artemis/) (an high performance Entity System Framework for games)

[![Build Status](https://travis-ci.org/vinova/Artemis-Ruby.png)](https://travis-ci.org/vinova/Artemis-Ruby)
[![Code Climate](https://codeclimate.com/repos/523fb2427e00a402fc01d777/badges/a836defa7344660e1951/gpa.png)](https://codeclimate.com/repos/523fb2427e00a402fc01d777/feed)

### Definitions

_This is a brief of [artemis manual](http://gamadu.com/artemis/manual.html)_

#### World

The World instance is an easily accessible context to manage all your entities, retrieve systems, components and managers.

#### Entity

Entities correspond to game objects, e.g., trees, defenders, monsters...

Entity = unique UUID + a bunch of components associate with it.

Entity contains several methods, such as for adding or removing components, and for adding or deleting the entity itself from the world.

`Entity` class is NOT inheritable!

#### Component 

Components are pure data classes, they do not have any logic in them other than that for setting/getting its data, and perhaps some helper methods. 

All component classes must inherits from `Component` class.

Example of components: position, physics, health, damage...

#### Aspect

Aspects are used by the systems as a filter against entities, to figure out if an entity should be inserted into a system.
They define the type of entities the system is interested in. Instead of thinking of systems processing entities, they rather process aspects of entities.

Example of aspect: entities contains 3 components (position, health, damage).

#### EntitySystem

Entity Systems are meant to process certain aspects of entities (entities possessing certain components).

Example of entity systems: movement system, collision handling system, rendering system, attack system...

#### ComponentMapper

Component mappers provide a fast way to access entities’ components. Although you can retrieve components using the getComponent method of the Entity class, you should NOT do this while processing entities continuously, as using component mappers is a faster way of doing it.

#### Managers

Managers sit on the sidelines and help you manage and organize your entities. There are two primary managers that are core to Artemis, they are the `EntityManager` and `ComponentManager`. All other managers are add-on or "custom" managers that can be added into your world instance.

### Relationship between definitions

We can have many worlds in a game.

Each world has many entities, aspects, systems, managers.

Each entity has many components.

Each aspect filters entities by the components the entity has.

Each system processes aspects of entities.

Managers are used to manage entities & components.

### Progress

- [ ] Aspect.java
- [x] Component.java
- [ ] ComponentManager.java
- [ ] ComponentMapper.java
- [x] ComponentType.java
- [ ] Entity.java **WIP**
- [ ] EntityManager.java
- [x] EntityObserver.java _don't see it's neccessary_
- [ ] EntitySystem.java
- [x] Manager.java
- [ ] World.java
- [ ] managers/GroupManager.java
- [ ] managers/PlayerManager.java
- [ ] managers/TagManager.java
- [ ] managers/TeamManager.java
- [x] utils/Bag.java _currently is ruby Array_
- [ ] utils/FastMath.java
- [x] utils/ImmutableBag.java _currently is Bag_
- [ ] utils/Timer.java
- [ ] utils/TrigLUT.java
- [ ] utils/Utils.java
- [ ] systems/DelayedEntityProcessingSystem.java
- [ ] systems/EntityProcessingSystem.java
- [ ] systems/IntervalEntityProcessingSystem.java
- [ ] systems/IntervalEntitySystem.java
- [ ] systems/VoidEntitySystem.java

