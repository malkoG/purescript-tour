module TodoMvc.View (getTodoElement, getTodoCount, view) where

import TodoMvc.Model (TodoState, ApplicationState)

import Substitute (substitute)


import Web.DOM.Element (Element, toNode, fromNode, toParentNode)
import Web.DOM.ParentNode (querySelector, QuerySelector(..))
import Web.DOM.Node (Node, deepClone, setTextContent)

import Prelude
import Data.Array

getTodoElement :: TodoState -> String
getTodoElement { text, completed } =
  substitute
    """
    <li ${listCssClass}>
      <div class="view">
        <input
          ${checkboxStatus}
          class="toggle"
          type="checkbox" />
        <label>${text}</label>
        <button class="destroy"></button>
      </div>
      <input class="edit" value="${text}">
    </li>
    """
    { text: text
    , listCssClass: if completed then
          "class=\"completed\""
        else
          ""
    , checkboxStatus: if completed then
          "checked"
        else
          ""
    }

getTodoCount :: Array TodoState -> String
getTodoCount todos =
  let
    notCompleted = filter (\todo -> not todo.completed) todos
    countOfTodos = length notCompleted
  in
    if countOfTodos == 1 then
      "1 Item left"
    else
      show (countOfTodos) <> " Items left"


view :: Element -> ApplicationState -> Element
view targetElement { currentFilter, todos } = do
  copiedNode <- deepClone $ toNode targetElement
  futureElement <- toParentNode $ fromNode $ copiedNode
  todoListElement <- querySelector (QuerySelector ".todo-list") futureElement
  counterElement <- querySelector (QuerySelector ".todo-count") futureElement
  filtersElement <- querySelector (QuerySelector ".filters") futureElement

  futureElement
