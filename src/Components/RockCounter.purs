module Components.RockCounter
  ( Input
  , Output
  , component
  ) where

import Prelude

import Effect.Class (class MonadEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE

type Input = { name :: String }

type Output = { count :: Int }

type State = { name :: String, count :: Int }

data Action = ModifyCount Int | SetCount Int

component :: forall query m. MonadEffect m => H.Component query Input Output m
component = H.mkComponent
  { initialState
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  , render
  }

initialState :: Input -> State
initialState input = { name: input.name, count: 0 }

handleAction :: forall m. Action -> H.HalogenM State Action () Output m Unit
handleAction = case _ of
  ModifyCount n -> do
    count <- _.count <$> H.get
    let newCount = count + n
    if newCount >= 0 then do
      H.modify_ \state -> state { count = newCount }
      raiseCount
    else pure unit
  SetCount n
    | n >= 0 -> do
        H.modify_ \state -> state { count = n }
        raiseCount
    | otherwise -> pure unit
  where
  raiseCount = do
    count <- _.count <$> H.get
    H.raise { count }

render :: forall m. State -> H.ComponentHTML Action () m
render state = HH.div_
  [ HH.h2_ [ HH.text state.name ]
  , HH.div_
      [ HH.text $ "Count: " <> show state.count <> (if state.count >= 50 then " Done" else "") ]
  , HH.div_
      [ HH.button [ HE.onClick $ const $ ModifyCount 1 ] [ HH.text "Increment" ]
      , HH.button
          [ HE.onClick $ const $ ModifyCount (-1) ]
          [ HH.text "Decrement" ]
      , HH.button
          [ HE.onClick $ const $ SetCount 0 ]
          [ HH.text "Reset" ]
      ]
  ]
