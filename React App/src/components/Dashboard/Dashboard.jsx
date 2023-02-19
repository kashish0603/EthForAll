import React from "react";
import "../Dashboard/Dashboard.css";
import { Product } from "../Product/Product.jsx";

export const Dashboard = () => {
	return (
		<div className="dashboard">
			<div className="docs-main">
				<div className="card-docs bg-light p-3 flex">
					<h3 className="my-2">Essentials</h3>
					<nav>
						<ul className="flex-row">
							<li>
								<a className="text-primary" href="#">
									Introduction
								</a>
							</li>
							<li>
								<a href="#">About BondChain</a>
							</li>
							<li>
								<a href="#">Installation</a>
							</li>
						</ul>
					</nav>
					<h3 className="my-2">Deployment</h3>
					<nav>
						<ul className="flex-row">
							<li>
								<a href="#">Its time to mint</a>
							</li>
							<li>
								<a href="#">Invest Now</a>
							</li>
							<li>
								<a href="#">Managing resources</a>
							</li>
							<li>
								<a href="#">Upgrade & Downgrade</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<div className="products">
				<Product
					name="Tata Motors"
					desc="Tata Motors is offering bonds worth 100 crore rupees to interested investors. These bonds are being offered in fractions starting at 10,000 rupees, making it easier for smaller investors to participate. Investing in these bonds may provide an opportunity for investors to earn a return on their investment through regular interest payments, while also supporting the growth of Tata Motors."
					logo="https://cdn.globalcarsbrands.com/wp-content/uploads/2015/01/TATA-Motors.jpg"
					min="10000"
				/>
				<Product
					name="LIC"
					desc="LIC (Life Insurance Corporation of India) is offering government bonds worth 500 crore rupees to interested investors. These bonds are being offered in fractions starting at 20,000 rupees, making it easier for smaller investors to participate. Investing in these government bonds may provide a secure and stable investment opportunity for investors, with the backing of the Indian government."
					logo="https://hindubabynames.info/downloads/wp-content/themes/hbn_download/download/insurance-companies/lic-logo.png"
					min="20000"
				/>
				<Product
					name="Kalyan Jewellers"
					desc="Kalyan Jewellers is offering bonds worth 100 crore rupees to interested investors. These bonds are being offered in fractions starting at 5,000 rupees, making it easier for smaller investors to participate. Investing in these bonds may provide an opportunity for investors to earn a return on their investment through regular interest payments, while also supporting the growth of Kalyan Jewellers."
					logo="https://kikkidu.com/wp-content/uploads/2015/01/Kalyan-Logo.jpg"
					min="5000"
				/>
				<Product
					name="Tech Mahindra"
					desc="Tech Mahindra is offering corporate bonds worth 100 crore rupees to interested investors. These bonds are being offered in fractions starting at 5,000 rupees, making it easier for smaller investors to participate. Investing in these corporate bonds may provide an opportunity for investors to earn a return on their investment through regular interest payments, while also supporting the growth of Tech Mahindra."
					logo="https://img.etimg.com/thumb/width-1200,height-900,imgsize-35143,resizemode-1,msid-74861592/tech/ites/tech-mahindra-tweaks-brand-logo-to-convey-solidarity-in-fight-against-covid-19.jpg"
					min="5000"
				/>
			</div>
		</div>
	);
};
