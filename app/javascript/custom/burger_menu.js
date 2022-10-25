document.addEventListener('DOMContentLoaded', () => {
  // navbar-burger 要素をすべて取得する。
  const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0)

  // それぞれにクリックイベントを追加する
  $navbarBurgers.forEach(el => {
    el.addEventListener('click', () => {
      // data-target属性からターゲットを取得する
      const target = el.dataset.target
      const $target = document.getElementById(target)

      // navbar-burger と navbar-menu の両方で is-active クラスをトグルさせる。
      el.classList.toggle('is-active')
      $target.classList.toggle('is-active')
    })
  })
})
