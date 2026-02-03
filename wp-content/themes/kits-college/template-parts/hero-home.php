<?php
/**
 * Hero block for front page
 *
 * @package KITS_College
 */
$tagline = get_bloginfo( 'description' );
$title   = get_bloginfo( 'name' );
?>
<section class="hero">
	<div class="container">
		<h1><?php echo esc_html( $title ); ?></h1>
		<?php if ( $tagline ) : ?>
			<p><?php echo esc_html( $tagline ); ?></p>
		<?php endif; ?>
		<a href="<?php echo esc_url( get_permalink( get_page_by_path( 'courses' ) ) ?: home_url( '/' ) ); ?>" class="btn"><?php esc_html_e( 'Explore Courses', 'kits-college' ); ?></a>
	</div>
</section>
