import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);
  store.dispatch = addingLoggingToDispatch(store);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});

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



const addingLoggingToDispatch = store => {
  const oldDispatch = store.dispatch;
  return action => {
    console.log('State pre-dispatch:', store.getState());
    console.log(action);
    let result = oldDispatch(action);
    console.log('State post-dispatch:', store.getState());
    return result;
  };
};


// const applyMiddlewares = (store, ...middlewares) => {
//   let dispatch = store.dispatch
//   middlewares.forEach((middleware) => {
//     dispatch = middleware(store)(dispatch);
//   });
//   return Object.assign({}, store, { dispatch });
// }
