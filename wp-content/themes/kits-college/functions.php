<?php
/**
 * KITS College theme functions and setup
 *
 * @package KITS_College
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

define( 'KITS_COLLEGE_VERSION', '1.0.0' );

function kits_college_setup() {
	load_theme_textdomain( 'kits-college', get_template_directory() . '/languages' );
	add_theme_support( 'title-tag' );
	add_theme_support( 'post-thumbnails' );
	add_theme_support( 'custom-logo', array(
		'height'      => 80,
		'width'       => 240,
		'flex-height' => true,
		'flex-width'  => true,
	) );
	add_theme_support( 'html5', array( 'search-form', 'comment-form', 'comment-list', 'gallery', 'caption', 'style', 'script' ) );
	add_theme_support( 'customize-selective-refresh-widgets' );
	add_theme_support( 'responsive-embeds' );
	add_theme_support( 'align-wide' );
	add_theme_support( 'wp-block-styles' );

	register_nav_menus( array(
		'primary'   => __( 'Primary Menu', 'kits-college' ),
		'footer'    => __( 'Footer Menu', 'kits-college' ),
	) );
}
add_action( 'after_setup_theme', 'kits_college_setup' );

function kits_college_scripts_styles() {
	wp_enqueue_style(
		'kits-college-fonts',
		'https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Raleway:wght@400;500;600;700&display=swap',
		array(),
		null
	);
	wp_enqueue_style(
		'kits-college-style',
		get_stylesheet_uri(),
		array( 'kits-college-fonts' ),
		KITS_COLLEGE_VERSION
	);
}
add_action( 'wp_enqueue_scripts', 'kits_college_scripts_styles' );

function kits_college_fallback_menu() {
	echo '<ul class="nav-list">';
	echo '<li><a href="' . esc_url( home_url( '/' ) ) . '">' . esc_html__( 'Home', 'kits-college' ) . '</a></li>';
	echo '</ul>';
}

function kits_college_body_classes( $classes ) {
	if ( ! is_singular() ) {
		$classes[] = 'hfeed';
	}
	if ( is_front_page() ) {
		$classes[] = 'front-page';
	}
	return $classes;
}
add_filter( 'body_class', 'kits_college_body_classes' );

function kits_college_excerpt_length( $length ) {
	return 25;
}
add_filter( 'excerpt_length', 'kits_college_excerpt_length' );

function kits_college_excerpt_more( $more ) {
	return '&hellip;';
}
add_filter( 'excerpt_more', 'kits_college_excerpt_more' );
