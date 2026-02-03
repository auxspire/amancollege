<?php
/**
 * Footer template
 *
 * @package KITS_College
 */
?>
</main><!-- #main -->

<footer class="site-footer">
	<div class="container">
		<div class="footer-inner">
			<div class="footer-brand">
				<?php if ( has_custom_logo() ) : ?>
					<?php the_custom_logo(); ?>
				<?php else : ?>
					<strong><?php bloginfo( 'name' ); ?></strong>
				<?php endif; ?>
				<p><?php bloginfo( 'description' ); ?></p>
			</div>
			<div class="footer-links">
				<?php
				wp_nav_menu( array(
					'theme_location' => 'footer',
					'menu_class'     => 'footer-menu',
					'container'      => false,
				) );
				?>
			</div>
			<div class="footer-contact">
				<p><?php echo esc_html( get_bloginfo( 'name' ) ); ?></p>
			</div>
		</div>
		<div class="footer-bottom">
			<p>&copy; <?php echo esc_html( date( 'Y' ) ); ?> <?php bloginfo( 'name' ); ?>. All rights reserved.</p>
		</div>
	</div>
</footer>

<?php wp_footer(); ?>
<script>
(function() {
	var nav = document.getElementById('main-nav');
	var toggle = document.querySelector('.nav-toggle');
	if (toggle && nav) {
		toggle.addEventListener('click', function() {
			nav.classList.toggle('is-open');
			toggle.setAttribute('aria-expanded', nav.classList.contains('is-open'));
		});
	}
})();
</script>
</body>
</html>
