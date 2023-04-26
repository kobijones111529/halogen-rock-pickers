module Components.App (component) where

import Prelude

import Components.RockCounter as RockCounter
import Data.Foldable (sum)
import Data.FunctorWithIndex (mapWithIndex)
import Data.Map (Map)
import Data.Map as Map
import Effect.Class (class MonadEffect)
import Halogen as H
import Halogen.HTML as HH
import Type.Proxy (Proxy(..))

type Slots = (rockCounter :: forall query. H.Slot query RockCounter.Output Int)

data Action = Count Int RockCounter.Output

_rockCounter = Proxy :: Proxy "rockCounter"

type State = { counts :: Map Int Int }

component :: forall query input output m. MonadEffect m => H.Component query input output m
component = H.mkComponent
  { initialState
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  , render
  }

initialState :: forall input. input -> State
initialState = const $ { counts: Map.empty }

handleAction
  :: forall output m
   . MonadEffect m
  => Action
  -> H.HalogenM State Action Slots output m Unit
handleAction = case _ of
  Count id output -> do
    H.modify_ \state -> state { counts = Map.insert id output.count state.counts }

render :: forall m. MonadEffect m => State -> H.ComponentHTML Action Slots m
render state = HH.div_
  [ HH.header_
      [ HH.h1_ [ HH.text "React Rock Pickers (but with Halogen)" ]
      , HH.p_
          [ HH.text
              "\
              \\"You ain't ever worked a day until you worked a day picking rocks.\" - \
              \  Mike Schlangen\
              \"
          ]
      ]
  , HH.h3_ [ HH.text $ "Total count: " <> show (sum $ Map.values state.counts) ]
  , HH.div_ $
      mapWithIndex
        ( \i name ->
            HH.div_ [ HH.slot _rockCounter i RockCounter.component { name } (Count i) ]
        )
        [ "Luke", "JJ", "Sam", "Pete" ]
  ]
