import { Link } from 'react-router-dom'

function Contact() {
  return (
    <div className="container mx-auto px-4 py-8">
      <header className="text-center mb-8">
        <h1 className="text-4xl font-display text-sol-orange-700 mb-4">
          🌮 Casa del Sol
        </h1>
        <p className="text-xl text-gray-600">
          Contact Us
        </p>
      </header>

      <nav className="flex justify-center space-x-6 mb-8">
        <Link 
          to="/" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Home
        </Link>
        <Link 
          to="/menu" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Menu
        </Link>
        <Link 
          to="/about" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          About
        </Link>
        <Link 
          to="/contact" 
          className="px-4 py-2 bg-sol-orange-500 text-white rounded hover:bg-sol-orange-600 transition-colors"
        >
          Contact
        </Link>
      </nav>

      <main className="text-center">
        <div className="max-w-2xl mx-auto">
          <h2 className="text-2xl font-display text-gray-800 mb-4">
            Get in Touch 📞
          </h2>
          <div className="bg-sol-orange-50 p-6 rounded-lg">
            <div className="grid md:grid-cols-2 gap-6">
              <div className="text-left">
                <h3 className="text-lg font-display text-sol-orange-700 mb-3">
                  📍 Location
                </h3>
                <p className="text-gray-600 mb-2">123 Sunset Boulevard</p>
                <p className="text-gray-600 mb-2">Los Angeles, CA 90028</p>
                <p className="text-gray-600">United States</p>
              </div>
              <div className="text-left">
                <h3 className="text-lg font-display text-sol-orange-700 mb-3">
                  📞 Contact Info
                </h3>
                <p className="text-gray-600 mb-2">Phone: (555) 123-4567</p>
                <p className="text-gray-600 mb-2">Email: info@casadelsol.com</p>
                <p className="text-gray-600">Instagram: @casadelsolLA</p>
              </div>
            </div>
            <div className="mt-6">
              <h3 className="text-lg font-display text-sol-orange-700 mb-3">
                🕒 Hours
              </h3>
              <div className="text-gray-600 text-sm">
                <p>Monday - Thursday: 11:00 AM - 9:00 PM</p>
                <p>Friday - Saturday: 11:00 AM - 10:00 PM</p>
                <p>Sunday: 12:00 PM - 8:00 PM</p>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}

export default Contact