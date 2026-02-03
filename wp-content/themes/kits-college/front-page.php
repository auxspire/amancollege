<?php
/**
 * Front page template (Home)
 *
 * @package KITS_College
 */

get_header();
?>

<?php get_template_part( 'template-parts/hero', 'home' ); ?>

<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
	<?php if ( get_the_content() ) : ?>
		<section class="section">
			<div class="container">
				<div class="entry-content">
					<?php the_content(); ?>
				</div>
			</div>
		</section>
	<?php endif; ?>
<?php endwhile; endif; ?>

<?php get_template_part( 'template-parts/section', 'courses' ); ?>
<?php get_template_part( 'template-parts/section', 'cta' ); ?>

<?php get_footer(); ?>
