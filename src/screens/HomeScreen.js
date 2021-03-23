import React, { useState } from 'react';
import { View, Text, StyleSheet, FlatList, Dimensions } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler';
import ButtonTile from '../components/ButtonTile';
import ModalCreateButton from '../components/ModalCreateButton';
import AsyncStorage from '@react-native-async-storage/async-storage';


// const buttonObj = {
//   buttonID: "",
//   title: "",
// }

// const testFunc = (buttonData) => {
//   var {buttonData} = {
//     currentDateTime: Date().toLocaleString(),
//     note: "",
//   }
// }


var data = [
    //{key: 1, title: 'coom', amount: 2},{key: 2, title: 'bum', amount: 2},{key: 3, title: 'poo', amount: 2},{key: 4, title: 'poops', amount: 2},{key: 5, title: 'poo', amount: 2},{key: 6, title: 'poo', amount: 2},{key: 7, title: 'poo', amount: 2},{key: 8, title: 'poo', amount: 2}
];
  
  const formatData = (data, numColumns) => {
    
    const numberOfFullRows = Math.floor(data.length / numColumns);
  
    let numberOfElementsLastRow = data.length - (numberOfFullRows * numColumns);
    while (numberOfElementsLastRow !== numColumns && numberOfElementsLastRow !== 0) {
      data.push({ buttonID: `blank-${numberOfElementsLastRow}`, empty: true });
      numberOfElementsLastRow++;
    }
  
    return data;
  };

  
  
  const numColumns = 3;
  export default class HomeScreen extends React.Component {

    static navigationOptions = ({navigation, screenProps}) => {
      const params = navigation.state.params || {};
    
      return {
        headerTitle: () => params.headerTitle,
        headerRight: () => params.headerRight,
      }
    }
    
    _setNavigationParams() {
      let headerTitle = <Text style={styles.headerTitle}>Click.</Text>;
      let headerRight = <TouchableOpacity onPress={this._headerButtonPress.bind(this)}>
                          <Text style={styles.headerBtn}>+</Text>
                        </TouchableOpacity>;
      this.props.navigation.setParams({ 
        headerTitle,
        headerRight, 
      });
    }
    
    componentDidMount() {
      this._setNavigationParams();
    }

    _headerButtonPress = () => {
      this.displayModal(true);
    }



    renderItem = ({ item, index }) => {
      if (item.empty === true) {
        return <View style={[styles.item, styles.itemInvisible]} />;
      }
      return (
        <View style={styles.item}>
            <ButtonTile 
                style={styles.item}
                title={item.title}
                //amount={item.amount}
            />
        </View>
      );
    };
  
    

    refreshTheList(reload){
      this.setState({
        refresh: reload,
      })
    }

    renderButtonList() {
      return(
        <FlatList
          data={formatData(data, numColumns)}
          style={styles.container}
          renderItem={this.renderItem}
          numColumns={numColumns}
          showsVerticalScrollIndicator={false}
          extraData={this.state.refresh}
        />
      )
    }

    state = {
      isVisible: false
    };

    displayModal(show){
      this.setState({
        isVisible: show,
      })
    }

    

    render() {
      modalStateChange = (currentState) => {
        this.displayModal(currentState);
      }      

      populateButtons = () => {
        AsyncStorage.getItem('buttonObj')
          .then((buttonObj) => {
            const b = buttonObj ? JSON.parse(buttonObj) : [];
            data = b;
            console.log(b);
            this.refreshTheList(true);
          });
      }
      
      return (
        <View style={styles.mainContainer}>
         <View style={styles.mainContainer}>
         {this.renderButtonList()}
         </View>
        {/* modal */}
        <ModalCreateButton 
          isVisible={this.state.isVisible}
          populateButtonsTap={() => populateButtons()}
          onCreateTap={() => modalStateChange(false)}
          
        />
        </View>
      );
    }

  }
  
  const styles = StyleSheet.create({
    
    
    mainContainer: {
      flex: 1,
      //backgroundColor: 'blue',
      justifyContent: 'center',
  },
    container: {
      flex: 1,
      marginVertical: 5,
      marginHorizontal: 5,
    },
    item: {
      backgroundColor: 'transparent',
      alignItems: 'center',
      justifyContent: 'center',
      flex: 1,
      margin: 1,
      height: Dimensions.get('window').width / numColumns, // approximate a square
    },
    itemInvisible: {
      backgroundColor: 'transparent',
    },
    itemText: {
      color: '#fff',
    },
    headerBtn: {
      fontSize: 25,
      color: 'black',
      paddingRight: 20,
    },
    headerTitle: {
      fontSize: 25,
      color: 'black',
    },
    modal: {
      flex: 1,
      alignItems: 'center',
      backgroundColor: '#00ff00',
      padding: 100,
    },
  });

