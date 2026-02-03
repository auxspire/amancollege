<?php
/**
 * Courses section (front page) – optional; show if Courses page exists
 *
 * @package KITS_College
 */
$courses_page = get_page_by_path( 'courses' );
if ( ! $courses_page ) {
	$courses_page = get_page_by_path( 'course' );
}
?>
<section class="section section-courses">
	<div class="container">
		<div class="section-title">
			<h2><?php esc_html_e( 'Our Courses', 'kits-college' ); ?></h2>
			<p><?php esc_html_e( 'Quality education for your future.', 'kits-college' ); ?></p>
		</div>
		<?php if ( $courses_page ) : ?>
			<p><a href="<?php echo esc_url( get_permalink( $courses_page ) ); ?>" class="btn"><?php esc_html_e( 'View All Courses', 'kits-college' ); ?></a></p>
		<?php endif; ?>
	</div>
</section>
