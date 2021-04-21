
const initSidebars = () => {
  // find the expanded one
  const sidebarLg = document.querySelector('#sidebar-lg');
  // find the expand button
  const collapseButton = document.querySelector('.collapse-action');
  // find the small one
  const sidebarSm = document.querySelector('#sidebar-sm');
  // find the collapse button
  const expandButton = document.querySelector('.expand-action');
  // add event listeners to both
  // When we click on collapse
  collapseButton.addEventListener('click', () => {
    console.log('hello');
    sidebarLg.classList.remove('d-flex');
    sidebarLg.classList.add('d-none');
    sidebarSm.classList.add('d-flex');
    sidebarSm.classList.remove('d-none');
  })

  expandButton.addEventListener('click', () => {
    sidebarLg.classList.add('d-flex');
    sidebarLg.classList.remove('d-none');
    sidebarSm.classList.remove('d-flex');
    sidebarSm.classList.add('d-none');
  })
  // When we click on expand

}

export { initSidebars }
