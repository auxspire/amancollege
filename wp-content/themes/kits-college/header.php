<?php
/**
 * Header template
 *
 * @package KITS_College
 */
?><!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="profile" href="https://gmpg.org/xfn/11">
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<header class="site-header">
	<div class="container">
		<div class="inner">
			<div class="site-logo">
				<a href="<?php echo esc_url( home_url( '/' ) ); ?>">
					<?php if ( has_custom_logo() ) : ?>
						<?php the_custom_logo(); ?>
					<?php else : ?>
						<span class="site-name"><?php bloginfo( 'name' ); ?></span>
					<?php endif; ?>
				</a>
			</div>
			<button type="button" class="nav-toggle" aria-label="<?php esc_attr_e( 'Toggle menu', 'kits-college' ); ?>" aria-expanded="false">
				<span></span><span></span><span></span>
			</button>
			<nav class="main-nav" id="main-nav" aria-label="<?php esc_attr_e( 'Primary', 'kits-college' ); ?>">
				<?php
				wp_nav_menu( array(
					'theme_location' => 'primary',
					'menu_class'     => 'nav-list',
					'container'      => false,
					'fallback_cb'    => 'kits_college_fallback_menu',
				) );
				?>
			</nav>
		</div>
	</div>
</header>

<main id="main" class="site-main">
