module TodoMvc.Model (TodoState, ApplicationState) where

import Data.Array

type TodoState =
  { text :: String
  , completed :: Boolean
  }

type ApplicationState =
  { currentFilter :: String
  , todos :: Array TodoState
  }