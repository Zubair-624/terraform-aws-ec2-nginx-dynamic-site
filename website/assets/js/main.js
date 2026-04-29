// ── Active nav link ──
const currentPage = window.location.pathname.split('/').pop() || 'index.html';
document.querySelectorAll('.nav-links a').forEach(link => {
  link.classList.remove('active');
  const href = link.getAttribute('href');
  if (href === currentPage || (currentPage === '' && href === 'index.html')) {
    link.classList.add('active');
  }
});

// ── Mobile menu toggle ──
const menuToggle = document.querySelector('.menu-toggle');
const navLinks = document.querySelector('.nav-links');
if (menuToggle && navLinks) {
  menuToggle.addEventListener('click', () => {
    navLinks.classList.toggle('open');
  });
  // Close on link click
  navLinks.querySelectorAll('a').forEach(a => {
    a.addEventListener('click', () => navLinks.classList.remove('open'));
  });
}

// ── Navbar scroll effect ──
const navbar = document.querySelector('.navbar');
window.addEventListener('scroll', () => {
  if (window.scrollY > 20) {
    navbar.style.borderBottomColor = 'rgba(255,255,255,0.12)';
    navbar.style.background = 'rgba(10,10,10,0.96)';
  } else {
    navbar.style.borderBottomColor = 'rgba(255,255,255,0.08)';
    navbar.style.background = 'rgba(10,10,10,0.85)';
  }
});

// ── Fade up on scroll ──
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.animationPlayState = 'running';
    }
  });
}, { threshold: 0.08 });

document.querySelectorAll('.fade-up').forEach(el => {
  el.style.animationPlayState = 'paused';
  observer.observe(el);
});

// ── Animate skill bars on scroll ──
const skillObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const fills = entry.target.querySelectorAll('.skill-bar-fill');
      fills.forEach(fill => {
        const width = fill.getAttribute('data-width');
        fill.style.width = width;
      });
    }
  });
}, { threshold: 0.2 });

document.querySelectorAll('.skills-grid').forEach(el => skillObserver.observe(el));
