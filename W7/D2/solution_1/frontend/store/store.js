import { createStore, applyMiddleware } from 'redux';
import RootReducer from '../reducers/root_reducer';

const configureStore = (preloadedState = {}) => {
  const store = createStore(RootReducer, preloadedState);
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
}

export default configureStore;

//
// function addingLoggingToDispatch(store) {
//   let oldDispatch = store.dispatch;
//     return (next) => {
//       return (action) =>{
//         console.log('State pre-dispatch:', store.getState());
//         console.log(action);
//         oldDispatch(action);
//         console.log('State post-dispatch:', store.getState());
//     };
//   };
// }
// export default configureStore;
