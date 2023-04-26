# React Rock Pickers (Translated to Halogen)

Mike has had enough of his city-slicker sons complaining about cleaning the bathrooms, folding laundry, and other household chores. Luke and his younger brothers are off to learn what it's like to work on a farm.

To make it more enjoyable, the brothers are going to make it a competition to see who can pick the most rocks. Create a rock picking tracker so they don't lose count.

## Setup

`fork`, `clone`, and `npm install`. The `App.js` and `RockCounter` components have already been started. No changes should be necessary to `App.js` for the Base Requirements. 

## Base Requirements

- When the `Increase` button is clicked, the total count for that brother should increase by `1`.
- When the `Decrease` button is clicked, the total count for that brother should decrease by `1`.
- When the `Reset` button is clicked, the total count for that brother should be set to `0`.

A deployed version of base mode can be found here: https://react-rock-pickers.netlify.com/

## Stretch

- Keep the counts above 0 (don't allow a decrease below 0)
- The brothers can stop after they pick 50 rocks. Put the word "Done" next to the number picked if they have picked 50 or more rocks (will need conditional rendering)
- In App, keep a total count of *all rocks picked*. This should be the sum of each RockCounter's "Rocks Picked" value.
    - You'll need a new piece of React state in App. (Maybe something like `totalRocksPicked`.)
    - You'll need to think of a way to provide each RockCounter component with the ability to modify the`totalRocksPicked` state that lives in App. (This is tricky since we haven't explicitly showed you how to accomplish this! 🙂)
