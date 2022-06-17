import React from 'react';
import Slider from 'react-slick';
import bg1 from '../../../../images/bg_1.jpg';
import bg2 from '../../../../images/bg_2.jpg';
const ServiceHome = () => {
	// const heroBanner: Array<{ title: string; caption: string }> = [
	// 	{
	// 		title: 'Free Shipping',
	// 		caption: 'Free Shipping',
	// 	},
	// 	{
	// 		title: '>Always Fresh',
	// 		caption: 'Product well package',
	// 	},
	// 	{
	// 		title: 'Superior Quality',
	// 		caption: 'Quality Products',
	// 	},
	// 	{
	// 		title: 'Support',
	// 		caption: '24/7 Support',
	// 	},
	// ];
	const settings = {
		dots: true,
		infinite: true,
		speed: 500,
		slidesToShow: 1,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 2000,
	};
	return (
		<section id='home-section' className='hero'>
			<div className='home-slider owl-carousel'>
				<Slider {...settings}>
					<div>
						<div
							className='slider-item'
							style={{ backgroundImage: `url(${bg1})` }}
						>
							<div className='overlay'></div>
							<div className='container'>
								<div
									className='
								row
								slider-text
								justify-content-center
								align-items-center
							'
									data-scrollax-parent='true'
								>
									<div className='col-md-12 text-center'>
										<h1 className='mb-2'>
											We serve Fresh Vegestables &amp;
											Fruits
										</h1>
										<h2 className='subheading mb-4'>
											We deliver organic vegetables &amp;
											fruits
										</h2>
										<p>
											<a
												href='#'
												className='btn btn-primary'
											>
												View Details
											</a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div>
						<div
							className='slider-item'
							style={{ backgroundImage: `url(${bg2})` }}
						>
							<div className='overlay'></div>
							<div className='container'>
								<div
									className='
								row
								slider-text
								justify-content-center
								align-items-center
								'
									data-scrollax-parent='true'
								>
									<div className='col-sm-12 text-center'>
										<h1 className='mb-2'>
											100% Fresh &amp; Organic Foods
										</h1>
										<h2 className='subheading mb-4'>
											We deliver organic vegetables &amp;
											fruits
										</h2>
										<p>
											<a
												href='#'
												className='btn btn-primary'
											>
												View Details
											</a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</Slider>
			</div>
		</section>
	);
};

export default ServiceHome;
