<?php
/**
 * Single post template
 *
 * @package KITS_College
 */

get_header();
?>

<?php while ( have_posts() ) : the_post(); ?>
	<section class="hero hero-inner">
		<div class="container">
			<h1><?php the_title(); ?></h1>
			<p class="entry-meta"><?php echo get_the_date(); ?></p>
		</div>
	</section>
	<div class="container">
		<article id="post-<?php the_ID(); ?>" <?php post_class( 'page-content' ); ?>>
			<div class="entry-content">
				<?php the_content(); ?>
			</div>
		</article>
	</div>
<?php endwhile; ?>

<?php get_footer(); ?>
