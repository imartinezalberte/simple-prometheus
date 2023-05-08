package main

import (
	"math/rand"

	"github.com/gin-gonic/gin"
	ginprometheus "github.com/zsais/go-gin-prometheus"
)

func main() {
	router := gin.Default()

	p := ginprometheus.NewPrometheus("gin")
	p.Use(router)

	g := router.Group("/api/v1")
	{
		g.GET("/hello", SayHello)
		g.GET("/bye", SayBye)
	}

	router.Run(":8080")
}

func SayHello(c *gin.Context) {
	c.JSON(randomStatusCodes(), gin.H{
		"message": "Hello world",
	})
}

func SayBye(c *gin.Context) {
	c.JSON(randomStatusCodes(), gin.H{
		"message": "Bye world",
	})
}

func randomStatusCodes() int {
	return rand.Intn(5) + 200
}
