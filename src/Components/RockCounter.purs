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

data Action = ModifyCount (Int -> Int)

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
  ModifyCount f -> do
    count <- max 0 <<< f <<< _.count <$> H.get
    H.modify_ \state -> state { count = count }
    raiseCount
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
      [ HH.button [ HE.onClick $ const $ ModifyCount (_ + 1) ] [ HH.text "Increment" ]
      , HH.button
          [ HE.onClick $ const $ ModifyCount (_ - 1) ]
          [ HH.text "Decrement" ]
      , HH.button
          [ HE.onClick $ const $ ModifyCount (const 0) ]
          [ HH.text "Reset" ]
      ]
  ]
