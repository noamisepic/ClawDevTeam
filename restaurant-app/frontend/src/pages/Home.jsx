import { Link } from 'react-router-dom'

function Home() {
  return (
    <div className="container mx-auto px-4 py-8">
      <header className="text-center mb-8">
        <h1 className="text-4xl font-display text-sol-orange-700 mb-4">
          🌮 Casa del Sol
        </h1>
        <p className="text-xl text-gray-600">
          Authentic Mexican Cuisine
        </p>
      </header>

      <nav className="flex justify-center space-x-6 mb-8">
        <Link 
          to="/" 
          className="px-4 py-2 bg-sol-orange-500 text-white rounded hover:bg-sol-orange-600 transition-colors"
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
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Contact
        </Link>
      </nav>

      <main className="text-center">
        <div className="max-w-2xl mx-auto">
          <h2 className="text-2xl font-display text-gray-800 mb-4">
            Welcome to Casa del Sol! ☀️
          </h2>
          <p className="text-gray-600 mb-6">
            Experience the warmth and flavors of authentic Mexican cuisine in a 
            welcoming atmosphere. From traditional tacos to signature margaritas, 
            every dish tells a story of heritage and passion.
          </p>
          <div className="bg-sol-orange-50 p-6 rounded-lg">
            <h3 className="text-lg font-display text-sol-orange-700 mb-2">
              🍽️ API Connection Test
            </h3>
            <button 
              onClick={() => {
                fetch('/api/health')
                  .then(res => res.json())
                  .then(data => {
                    alert('Backend connected! Status: ' + data.status)
                  })
                  .catch(err => {
                    alert('Backend not connected yet: ' + err.message)
                  })
              }}
              className="px-4 py-2 bg-sol-orange-500 text-white rounded hover:bg-sol-orange-600 transition-colors"
            >
              Test Backend Connection
            </button>
          </div>
        </div>
      </main>
    </div>
  )
}

export default Home