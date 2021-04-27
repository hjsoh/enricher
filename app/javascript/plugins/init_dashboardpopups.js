
const initDashboardPopups = () => {
  const cards = document.querySelectorAll('.card.card-select');
  const participants = document.querySelectorAll('#chat-participants');
  if (cards.length > 0) {
    cards.forEach((card) => {
      $('[data-toggle="tooltip"]').tooltip();
    })
  }
  else {
    participants.forEach((participant) => {
      $('[data-toggle="tooltip"]').tooltip();
    })
  }
}

export { initDashboardPopups }
