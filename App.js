import { createAppContainer } from 'react-navigation';
import { createStackNavigator } from 'react-navigation-stack';
import HomeScreen from './src/screens/HomeScreen';
import TestScreen from './src/screens/TestScreen';

const navigator = createStackNavigator(
{
  Home: { screen: HomeScreen },
  Test: { screen: TestScreen},
}, {
  initialRouteName: 'Home',
  defaultNavigationOptions: {
    title: 'ppap',
  },

});

export default createAppContainer(navigator);
