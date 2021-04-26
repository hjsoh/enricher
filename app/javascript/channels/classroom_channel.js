import consumer from "./consumer";

const initClassroomCable = () => {
  const messagesContainer = document.querySelector('.messages');
  console.log('cable');
  if (messagesContainer) {
    const id = messagesContainer.dataset.classroom;
    console.log('id', id);

    consumer.subscriptions.create({ channel: "ClassroomChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.querySelector('.list-unstyled').insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initClassroomCable };