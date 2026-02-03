<?php
/**
 * Main template
 *
 * @package KITS_College
 */

get_header();
?>

<?php if ( have_posts() ) : ?>
	<div class="container">
		<div class="page-content">
			<?php while ( have_posts() ) : the_post(); ?>
				<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<header class="entry-header">
						<h2><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
					</header>
					<div class="entry-content">
						<?php the_excerpt(); ?>
					</div>
				</article>
			<?php endwhile; ?>
			<?php the_posts_navigation(); ?>
		</div>
	</div>
<?php else : ?>
	<div class="container">
		<div class="page-content">
			<p><?php esc_html_e( 'Nothing found.', 'kits-college' ); ?></p>
		</div>
	</div>
<?php endif; ?>

<?php get_footer(); ?>
