<?php
/**
 * Call-to-action section
 *
 * @package KITS_College
 */
$contact_page = get_page_by_path( 'contact' );
?>
<section class="section section-cta" style="background: var(--color-bg-alt);">
	<div class="container">
		<div class="section-title">
			<h2><?php esc_html_e( 'Get in Touch', 'kits-college' ); ?></h2>
			<p><?php esc_html_e( 'We would love to hear from you.', 'kits-college' ); ?></p>
		</div>
		<?php if ( $contact_page ) : ?>
			<p style="text-align: center;"><a href="<?php echo esc_url( get_permalink( $contact_page ) ); ?>" class="btn btn-accent"><?php esc_html_e( 'Contact Us', 'kits-college' ); ?></a></p>
		<?php endif; ?>
	</div>
</section>
