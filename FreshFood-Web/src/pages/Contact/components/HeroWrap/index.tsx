import React from 'react';
import bg1 from '../../../../images/bg_1.jpg';

interface Props {}

const HeroWrap = (props: Props) => {
	return (
		<div
			className='hero-wrap hero-bread'
			style={{ backgroundImage: `url(${bg1})` }}
		>
			<div className='container'>
				<div className='row no-gutters slider-text align-items-center justify-content-center'>
					<div className='col-md-9 ftco-animate text-center'>
						<p className='breadcrumbs'>
							<span className='mr-2'>
								<a href='index.html'>Home</a>
							</span>{' '}
							<span>Contact us</span>
						</p>
						<h1 className='mb-0 bread'>Contact us</h1>
					</div>
				</div>
			</div>
		</div>
	);
};

export default HeroWrap;
