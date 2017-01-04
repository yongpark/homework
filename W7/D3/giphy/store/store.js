import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import RootReducer from '../reducers/root_reducer';
import {fetchSearchGiphys} from '../actions/giphy_actions.js';

const configureStore = () => {
  window.fetchSearchGiphys = fetchSearchGiphys;
  return createStore(RootReducer, applyMiddleware(thunk));
};

export default configureStore;
