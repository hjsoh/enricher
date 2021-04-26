



const initDashboardPopups = () => {
  const cards = document.querySelectorAll('.card.card-select');
  if (cards.length > 0) {
    cards.forEach((card) => {
      $('[data-toggle="tooltip"]').tooltip();
    })
  }
}


export { initDashboardPopups }
