Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.5-20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed:(){},icon: Icon(Icons.settings,size: 35,color: Colors.white,)),
                      IconButton(onPressed:(){},icon: Icon(Icons.settings,size: 35,color: Colors.white,)),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.5-15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed:(){},icon: Icon(Icons.settings,size: 35,color: Colors.white,)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: IconButton(onPressed:(){},icon: Icon(Icons.settings,size: 35,color: Colors.white,)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),