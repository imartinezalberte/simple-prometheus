package main

import (
	"math/rand"
	"time"

	ginzap "github.com/gin-contrib/zap"
	"github.com/gin-gonic/gin"
	ginprometheus "github.com/zsais/go-gin-prometheus"
	"go.uber.org/zap"
)

func main() {
	router := gin.Default()

	p := ginprometheus.NewPrometheus("gin")
	logger, _ := zap.NewProduction()

	router.Use(ginzap.Ginzap(logger, time.RFC3339, true))
	router.Use(ginzap.RecoveryWithZap(logger, true))
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
